CREATE OR REPLACE FUNCTION create_exercise (
    exercise_name VARCHAR(100),
    exercise_type VARCHAR(20)
)
RETURNS INT AS $$
DECLARE
    new_exercise_id INT;
BEGIN 
    INSERT INTO factExercise (
        exercisename,
        type
    )
    VALUES (
        exercise_name,
        exercise_type
    )
    RETURNING exerciseid INTO new_exercise_id;

    RETURN new_exercise_id;
END;
$$ LANGUAGE plpgsql;
