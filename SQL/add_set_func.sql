CREATE OR REPLACE FUNCTION add_set (
    user_exercise_id INT DEFAULT NULL 
    ,exercise_id INT DEFAULT NULL
    ,reps_param INT DEFAULT NULL
    ,weight_param NUMERIC(5,2) DEFAULT NULL
    ,duration_param INTERVAL DEFAULT NULL 
    ,distance_param FLOAT DEFAULT NULL 
    ,rpe_param INT DEFAULT NULL 
    ,notes_param VARCHAR(100) DEFAULT NULL 
    ,targetarea_param VARCHAR(50) DEFAULT NULL 
)
RETURNS INT AS $$
DECLARE 
    next_set_number INT; 
    exercise_type TEXT;
BEGIN 
    IF exercise_id IS NULL OR user_exercise_id IS NULL THEN
        RAISE EXCEPTION 'exercise_id and user_exercise_id must be provided';
    END IF;

    SELECT type INTO exercise_type
    FROM factExercise
    WHERE exerciseid = exercise_id;

    IF exercise_type = 'resistance' THEN
        SELECT COALESCE(MAX(setnumber), 0) + 1 INTO next_set_number
        FROM factResistance
        WHERE userexerciseid = user_exercise_id AND sessiondate = CURRENT_DATE;

        INSERT INTO factResistance (
            userexerciseid, sessiondate, setnumber,
            reps, weightused, notes, rpe
        )
        VALUES (
            user_exercise_id, CURRENT_DATE, next_set_number,
            reps_param, weight_param, notes_param, rpe_param
        );

    ELSIF exercise_type = 'cardio' THEN
        SELECT COALESCE(MAX(setnumber), 0) + 1 INTO next_set_number
        FROM factCardio
        WHERE userexerciseid = user_exercise_id AND sessiondate = CURRENT_DATE;

        INSERT INTO factCardio (
            userexerciseid, sessiondate, setnumber,
            rpe, duration, distance, notes
        )
        VALUES (
            user_exercise_id, CURRENT_DATE, next_set_number,
            rpe_param, duration_param, distance_param, notes_param
        );
    
    ELSIF exercise_type = 'mobility' THEN 
        SELECT COALESCE(MAX(setnumber), 0) + 1 INTO next_set_number
        FROM factMobility
        WHERE userexerciseid = user_exercise_id AND sessiondate = CURRENT_DATE;

        INSERT INTO factMobility (
            userexerciseid, sessiondate, setnumber,
            rpe, duration, targetarea, notes
        )
        VALUES (
            user_exercise_id, CURRENT_DATE, next_set_number,
            rpe_param, duration_param, targetarea_param, notes_param
        );

    ELSIF exercise_type = 'core' THEN 
        SELECT COALESCE(MAX(setnumber), 0) + 1 INTO next_set_number
        FROM factCore
        WHERE userexerciseid = user_exercise_id AND sessiondate = CURRENT_DATE;

        INSERT INTO factCore (
            userexerciseid, sessiondate, setnumber,
            reps, rpe, duration, weightused
        )
        VALUES (
            user_exercise_id, CURRENT_DATE, next_set_number,
            reps_param, rpe_param, duration_param, weight_param
        );

    ELSIF exercise_type = 'functional' THEN 
        SELECT COALESCE(MAX(setnumber), 0) + 1 INTO next_set_number
        FROM factFunctional
        WHERE userexerciseid = user_exercise_id AND sessiondate = CURRENT_DATE;

        INSERT INTO factFunctional (
            userexerciseid, sessiondate, setnumber,
            reps, rpe, duration, weightused
        )
        VALUES (
            user_exercise_id, CURRENT_DATE, next_set_number,
            reps_param, rpe_param, duration_param, weight_param
        );

    ELSE
        RAISE EXCEPTION 'Unsupported exercise type: %', exercise_type;
    END IF;


    RETURN next_set_number;
END;
$$ LANGUAGE plpgsql;