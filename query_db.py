"""This module retrieves information from the database and returns a list of user specific exercises in the form of their UserExerciseID"""

import sqlite3

conn = sqlite3.Connection(None)
