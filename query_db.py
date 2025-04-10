"""This module retrieves information from the database and
returns a list of user specific exercises in the form of their UserExerciseID"""

import sqlite3


def connect(db_path: str = "") -> sqlite3.Connection:
    """This function connects to the database
     Input:
        db_path(str): The pathway to the database
    Returns:
        sqlite3.Connection"""
    return sqlite3.Connection(db_path)
