import base64
import io

import matplotlib
from pytesseract import pytesseract
from PIL import Image
import keras_ocr
import matplotlib.pyplot as plt



from image_analysis import *

def extract_text(pipeline, img):
    """
    Extracts text from the image using the provided OCR pipeline.
    :param pipeline: The OCR pipeline used for text recognition.
    :param img: The image from which to extract text.
    :return: The extracted text.
    :requires: The OCR pipeline must be initialized and trained.
               The image (img) must be in a format compatible with the OCR pipeline.
    :ensures: The returned text is the result of OCR processing on the input image.
              The returned text is a string.
    """
    prediction_groups = pipeline.recognize(img)
    pc = prediction_groups[0]

    for text, box in pc:
        if text.isnumeric():
            return text


def pathfind(loadedImg, start_point, end_point, pipeline):
    """
    Finds a path in the loaded image from the start point to the end point and visualizes it.
    :param loadedImg: The loaded image on which the pathfinding will be performed.
    :param start_point: The starting point (x, y) coordinates for the pathfinding.
    :param end_point: The ending point (x, y) coordinates for the pathfinding.
    :param pipeline: The OCR pipeline used for additional processing.
    :return: Base64 encoded image of the path in JPEG format.
    :requires: The loaded image must be in a format compatible with the pathfinding algorithm.
               The start_point and end_point must be valid coordinates within the loaded image.
               The OCR pipeline must be initialized and trained.
    :ensures: The returned image is a visual representation of the path from start_point to end_point.
              The returned image is encoded in base64 format.
    """
    path = astar(loadedImg, start_point, end_point)
    new_image = draw_path(loadedImg, path)
    rgb_img = new_image.convert('RGB')
    buffer = io.BytesIO()
    rgb_img.save(buffer, format="JPEG")
    img_b64 = base64.b64encode(buffer.getvalue())

    return img_b64

