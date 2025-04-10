"""This is the base class for adding exercises and weights"""

from typing import Union


class Exercises:
    """This will track be used for adding data to
    each users on the database"""

    def __init__(self, user: str) -> None:
        self.user = user
        # Going to add a module that returns a list based on querying the database
        self.exercise_list = None

    def add_exercise(self, exercise_name: str) -> dict:
        """This will check if the exercise already exists in
        the database, if not the exercise will be added"""

    def remove_exercise(self, exercise_name: str) -> Union[dict, None]:
        """This will remove an exercise from a users profile"""

    def delete_user(self) -> None:
        """This will delete the user and all associated
        data from the database"""
