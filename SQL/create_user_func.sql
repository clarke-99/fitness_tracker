CREATE OR REPLACE FUNCTION create_new_user(
    f_name VARCHAR,
    l_name VARCHAR,
    sex BOOLEAN,
    email VARCHAR,
    dob DATE,
    username VARCHAR,
    password_hash VARCHAR,
    height_cm SMALLINT,
    weight_kg SMALLINT,
    date_recorded DATE DEFAULT CURRENT_DATE
)
RETURNS INT AS $$
DECLARE
    new_user_id INT;
BEGIN
    -- Insert into dimUser
    INSERT INTO dimUser (FirstName, LastName, SexMale, Email, DOB)
    VALUES (f_name, l_name, sex, email, dob)
    RETURNING UserID INTO new_user_id;

    -- Insert into authUser
    INSERT INTO authUser (UserName, Password, UserID)
    VALUES (username, password_hash, new_user_id);

    -- Insert into factUserMetrics
    INSERT INTO factUserMetrics (UserID, HeightCm, WeightKg, DateRecorded)
    VALUES (new_user_id, height_cm, weight_kg, date_recorded);

    RETURN new_user_id;
END;
$$ LANGUAGE plpgsql;
