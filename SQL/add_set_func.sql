-- has to select the userexerciseid from assocuserexercise
-- set ID is int will be reset to 1 if there are no userexerciseif for that day using coalesce and lag 
-- need params: reps, weightused, sessiondate (this can be set automatically) and set notes 

CREATE FUNCTION add_set(
  reps_param INT
  ,weight_param DECIMAL(5,2)
  ,notes_param VARCHAR(100)
  ,userID_param INT 
)
RETURNS INT AS $$
DECLARE
    setID INT; 
    UserExerciseID INT;
BEGIN 
    SELECT userex.UserExerciseID INTO factSet
    FROM assocUserExercise AS userex 
    WHERE userex.UserID = userID_param;

    WITH userexercise AS (
        SELECT 
            userex.UserExerciseID AS ExID
        FROM assocUserExercise AS userex 
        WHERE userex.UserID = userID_param 
    )
    INSERT INTO factSet(
        UserExerciseID
        ,SetNumber
        ,Reps 
        ,WeightUsed
        ,SetNotes
    )
    VALUES(
        (SELECT ExID FROM userexercise)
        ,(SELECT 
            COALESCE(LAG(SetNumber), 1) OVER(PARTITION BY SessionDate)
        FROM factSet
        WHERE UserExerciseID = (SELECT ExID FROM userexercise))
        ,reps_param
        ,weight_param
        ,notes_param
    )
END;
$$ LANGUAGE plpgsql;