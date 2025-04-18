
CREATE OR REPLACE FUNCTION create_new_user(
    f_name VARCHAR,
    l_name VARCHAR,
    sex BOOLEAN,
    email VARCHAR,
    dob DATE,
    new_username VARCHAR,
    password_hash VARCHAR,
    height_cm SMALLINT,
    weight_kg SMALLINT,
    date_recorded DATE DEFAULT CURRENT_DATE
)
RETURNS INT AS $$
DECLARE
    new_user_id INT;
    check_username VARCHAR;
BEGIN
    -- Check user name doesn't exist
    SELECT username INTO check_username FROM authuser WHERE username = new_username;
    IF check_username IS NOT NULL THEN 
        RAISE EXCEPTION 'Username taken: %', check_username;
    END IF;

    -- Insert into dimUser
    INSERT INTO dimUser (FirstName, LastName, SexMale, Email, DOB)
    VALUES (f_name, l_name, sex, email, dob)
    RETURNING UserID INTO new_user_id;

    -- Insert into authUser
    INSERT INTO authUser (UserName, Password, UserID)
    VALUES (new_username, password_hash, new_user_id);

    -- Insert into factUserMetrics
    INSERT INTO factUserMetrics (UserID, HeightCm, WeightKg, DateRecorded)
    VALUES (new_user_id, height_cm, weight_kg, date_recorded);

    RETURN new_user_id;
END;
$$ LANGUAGE plpgsql;
-- SELECT create_new_user(
--     'TestFirst'::VARCHAR,
--     'TestLast'::VARCHAR,
--     TRUE,
--     'testuser@example.com'::VARCHAR,
--     '1995-06-15'::DATE,
--     'testuser123'::VARCHAR,
--     'hashedpassword123'::VARCHAR,
--     180::SMALLINT,
--     75::SMALLINT,
--     '2025-04-10'::DATE
-- );
