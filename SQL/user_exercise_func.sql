CREATE OR REPLACE FUNCTION add_user_exercise(
    user_id INT,
    exercise_name_param VARCHAR,
    exercise_type_param VARCHAR
)
RETURNS INT AS $$
DECLARE
    exercise_id INT;
    user_exercise_id INT;
BEGIN
    -- Match or create exercise
    exercise_id := match_exercise(exercise_name_param, exercise_type_param);

    -- Check if link already exists
    SELECT UserExerciseID INTO user_exercise_id
    FROM assocUserExercise
    WHERE UserID = user_id AND ExerciseID = exercise_id;

    -- Insert link if needed
    IF user_exercise_id IS NULL THEN
        INSERT INTO assocUserExercise (UserID, ExerciseID)
        VALUES (user_id, exercise_id)
        RETURNING UserExerciseID INTO user_exercise_id;
    END IF;

    RETURN user_exercise_id;
END;
$$ LANGUAGE plpgsql;
