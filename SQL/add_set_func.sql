-- has to select the userexerciseid from assocuserexercise
-- set ID is int will be reset to 1 if there are no userexerciseif for that day using coalesce and lag 
-- need params: reps, weightused, sessiondate (this can be set automatically) and set notes 

CREATE FUNCTION add_set(
  reps_param INT
  ,weight_param DECIMAL(5,2)
  ,notes_param
)
RETURNS INT AS $$
DECLARE
    