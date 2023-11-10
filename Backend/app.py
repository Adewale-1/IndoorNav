import base64
import io
import json
import os

import cv2
import keras_ocr
from flask import Flask, request, flash, redirect, render_template, jsonify
from PIL import Image
import time

from CSVUtils import *
from image_analysis import *
from image_reader import pathfind, extract_text

pipeline = None


def create_app():

    """
        Requires:
        1. The server must be running and accessible.
        2. A POST request must be made to the server's root ('/') with 
            a JSON body containing 'image' and 'room_number' keys. The 'image' value should
            be a base64 encoded image, and 'room_number' should be a string representing the
            room number.
        3. The 'image' should contain readable text that can be processed by the OCR pipeline.
        4. The room numbers specified in the image and the 'room_number' value should exist 
            in the CSV file used by the `findCoordinates` function.
        5. If the floor number derived from the start room is 3- which represents 31 -  or 4, the corresponding 
            image file (goodFloor31.png or goodFloor4.png) must exist in the current directory.

        Ensures:
        1. If all preconditions are met, the function will return a string representation 
            of the image with the path from the start room to the end room.
        2. If the floor number is not 3- which represents 31 - or 4, the function will return the string "Noneee".
        3. The function will print various status messages and the total runtime to the 
            console.
    """
    app = Flask(__name__)
    app.secret_key = 'super secret key'

    @app.route('/parseImage')
    def hello_world():  # put application's code here
        return 'Hello World!'

    @app.route('/', methods=['POST'])
    def upload_image():

        now = time.time()

        data = request.data
        json_data = json.loads(data.decode('utf-8'))
        img_data = json_data['image']
        roomNumber = json_data['room_number']
        imgStart = base64.b64decode(img_data) # Gets actual image to later parse
        img_arr = np.frombuffer(imgStart, dtype=np.uint8)
        img_arr = cv2.imdecode(img_arr, cv2.IMREAD_COLOR)

        print("=============EXTRACTING TEXT=============")
        text = str(extract_text(pipeline, [img_arr]))
        print(f"=============TEXT EXTRACTED: {text}=============")

        print("=============DETERMINING PATH=============")

        if img_data:
            # try:
            startRoom = text
            print(startRoom)
            endRoom = roomNumber
            pos1 = findCoordinates(startRoom)
            print(pos1)

            xStart = int(pos1[0])
            yStart = int(pos1[1])
            floor = int(pos1[2])
            pos2 = findCoordinates(endRoom)
            xEnd = int(pos2[0])
            yEnd = int(pos2[1])

            img = None

            if floor == 3:
                img = Image.open("goodFloor31.png")
            elif floor == 4:
                img = Image.open("goodFloor4.png")
            print(xStart, yStart, 'nums', xEnd, yEnd)

            loadedImg = np.array(img)
            start_point = (yStart, xStart)
            end_point = (yEnd, xEnd)

            img_str = pathfind(loadedImg, start_point, end_point, pipeline)
            print("=============FINISHED PATH=============")
            print(f"Total Runtime: {time.time()-now}s")

            return img_str

        else:
            return "Noneee"

    return app


if __name__ == '__main__':

    pipeline = keras_ocr.pipeline.Pipeline()
    create_app().run(host="0.0.0.0", port=8080)



