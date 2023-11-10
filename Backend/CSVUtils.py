import csv


def findCoordinates(roomNum):
    """
        Finds the coordinates corresponding to a given room number in a CSV file.
        :param roomNum: The room number for which coordinates are to be found.
        :return: A list of coordinates (x, y, floor) if found, None otherwise.
        :requires: Assumes a CSV file named 'bolzrooms.csv' with a specific format.
                The CSV file must contain rows where the first column represents room numbers,
                and the subsequent columns represent coordinates (x, y, floor).
        :ensures: Returns the coordinates if the room number is found in the CSV file, and None otherwise.
    """
    with open('bolzrooms.csv', mode='r') as file:
        csvFile = csv.reader(file)
        for lines in csvFile:
            if lines[0] == roomNum:
                return lines[1:]
