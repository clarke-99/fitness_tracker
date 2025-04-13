CREATE OR REPLACE FUNCTION match_exercise (
    exercise_name VARCHAR(100),
    exercise_type VARCHAR(20)
)
RETURNS INT AS $$
DECLARE
    exercise_id INT;
BEGIN
    -- Try to fuzzy match an existing exercise
    SELECT fe.ExerciseID INTO exercise_id
    FROM factExercise fe
    WHERE similarity(fe.ExerciseName, exercise_name) > 0.4
      AND fe.Type = exercise_type
    ORDER BY similarity(fe.ExerciseName, exercise_name) DESC
    LIMIT 1;

    -- If not found, create it
    IF exercise_id IS NULL THEN
        exercise_id := create_exercise(exercise_name, exercise_type);
    END IF;

    -- Return the matched or newly created ID
    RETURN exercise_id;
END;
$$ LANGUAGE plpgsql;
