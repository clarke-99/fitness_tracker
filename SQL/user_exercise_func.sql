CREATE OR REPLACE FUNCTION add_user_exercise(
    username_param VARCHAR,
    exercise_name_param VARCHAR
)
RETURNS INT AS $$
DECLARE
    user_id INT;
    exercise_id INT;
    user_exercise_id INT;
BEGIN
    -- Get the user ID
    SELECT au.UserID INTO user_id
    FROM authUser au
    WHERE au.UserName = username_param;

    -- Check if exercise exists, if not insert it
    SELECT fe.ExerciseID INTO exercise_id
    FROM factExercise fe
    WHERE fe.ExerciseName = exercise_name_param;

    IF exercise_id IS NULL THEN
        INSERT INTO factExercise (ExerciseName)
        VALUES (exercise_name_param)
        RETURNING ExerciseID INTO exercise_id;
    END IF;

    -- Insert into assocUserExercise
    INSERT INTO assocUserExercise (UserID, ExerciseID)
    VALUES (user_id, exercise_id)
    RETURNING UserExerciseID INTO user_exercise_id;

    RETURN user_exercise_id;
END;
$$ LANGUAGE plpgsql;
