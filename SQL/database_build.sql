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

CREATE TABLE factExercise(
    ExerciseID SERIAL PRIMARY KEY
    ,ExerciseName VARCHAR(35)
);

CREATE TABLE assocUserExercise (
    UserExerciseID SERIAL PRIMARY KEY 
    ,ExerciseID INT 
    ,UserID INT 
    ,FOREIGN KEY (ExerciseID) REFERENCES factExercise(ExerciseID)
    ,FOREIGN KEY (UserID) REFERENCES dimUser(UserID)
); 

CREATE TABLE factSet(
    SetID INT 
    ,UserExerciseID INT REFERENCES assocUserExercise(UserExerciseID)
    ,Reps INT NOT NULL
    ,WeightUsed DECIMAL(5,2)
    ,SessionDate DATE NOT NULL 
    ,SetNotes VARCHAR(100)
    ,PRIMARY KEY (SetID, UserExerciseID)
);