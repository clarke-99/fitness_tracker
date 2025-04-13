create table dimUser (
  UserID SERIAL primary key,
  FirstName VARCHAR(35) not null,
  LastName varchar(35) not null,
  SexMale boolean,
  Email VARCHAR(50),
  DOB DATE not null
);

create table authUser (
  UserName varchar(35) primary key,
  Password varchar(100) not null,
  UserID INT,
  foreign KEY (UserID) references dimUser (UserID)
);

create table factUserMetrics (
  UserMetricID SERIAL primary key,
  UserID int,
  HeightCm smallint,
  WeightKg smallint,
  DateRecorded date,
  foreign key (UserID) references dimUser(UserID)
);

CREATE TABLE factexercise (
  exerciseid SERIAL PRIMARY KEY,
  exercisename VARCHAR(100) NOT NULL,
  type VARCHAR(20) NOT NULL CHECK (type IN ('resistance', 'cardio', 'mobility', 'core', 'functional'))
);


CREATE TABLE assocUserExercise (
    UserExerciseID SERIAL PRIMARY KEY 
    ,ExerciseID INT 
    ,UserID INT 
    ,FOREIGN KEY (ExerciseID) REFERENCES factExercise(ExerciseID)
    ,FOREIGN KEY (UserID) REFERENCES dimUser(UserID)
); 

CREATE TABLE factResistance(
    SetID INT 
    ,UserExerciseID INT REFERENCES assocUserExercise(UserExerciseID)
    ,Reps INT NOT NULL
    ,WeightUsed DECIMAL(5,2)
    ,SessionDate DATE NOT NULL 
    ,rpe INT CHECK (rpe BETWEEN 1 AND 5)               
    ,Notes VARCHAR(100)
    ,PRIMARY KEY (SetID, UserExerciseID, SessionDate)
);

CREATE TABLE factCardio (
  userexerciseid INT REFERENCES assocuserexercise(userexerciseid),
  sessiondate DATE,
  setnumber INT,
  rpe INT CHECK (rpe BETWEEN 1 AND 5),               
  duration INTERVAL NOT NULL,
  distance FLOAT NOT NULL,
  notes VARCHAR(100),
  PRIMARY KEY (userexerciseid, sessiondate, setnumber)
);

CREATE TABLE factMobility (
  userexerciseid INT REFERENCES assocuserexercise(userexerciseid),
  sessiondate DATE,
  setnumber INT,
  duration INTERVAL NOT NULL,
  rpe INT CHECK (rpe BETWEEN 1 AND 5),               
  targetarea VARCHAR(50),  -- e.g. "hips", "shoulders"
  notes VARCHAR(100),
  PRIMARY KEY (userexerciseid, sessiondate, setnumber)
);

CREATE TABLE factCore (
  userexerciseid INT REFERENCES assocuserexercise(userexerciseid),
  sessiondate DATE,
  setnumber INT,
  reps INT,
  rpe INT CHECK (rpe BETWEEN 1 AND 5),               
  duration INTERVAL,
  ,weightused DECIMAL(5,2)
  PRIMARY KEY (userexerciseid, sessiondate, setnumber)
);

CREATE TABLE factFunctional (
  userexerciseid INT REFERENCES assocuserexercise(userexerciseid),
  sessiondate DATE,
  setnumber INT,
  duration INTERVAL,
  rpe INT CHECK (rpe BETWEEN 1 AND 5),               
  reps INT,
  notes VARCHAR(100),
  PRIMARY KEY (userexerciseid, sessiondate, setnumber)
);
         
