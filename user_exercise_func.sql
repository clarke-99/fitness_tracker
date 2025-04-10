CREATE OR REPLACE FUNCTION add_user_exercise(
    username VARCHAR,
    exercise_id INT
)
RETURNS INT AS $$
DECLARE
    user_id INT;
    user_exercise_id INT;
BEGIN
    SELECT UserID INTO user_id FROM authUser WHERE UserName = username;

    INSERT INTO assocUserExercise (UserID, ExerciseID)
    VALUES (user_id, exercise_id)
    RETURNING UserExerciseID INTO user_exercise_id;

    RETURN user_exercise_id;
END;
$$ LANGUAGE plpgsql;
