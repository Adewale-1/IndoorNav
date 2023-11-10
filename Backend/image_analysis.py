import numpy as np
import heapq
from PIL import Image, ImageDraw


def load_image(file_path):
    """
        Loads an image from the specified file path.
        :param file_path: The path to the image file.
        :return: A NumPy array representing the loaded image.
        :requires: The file_path must point to a valid image file.
        :ensures: The returned array represents the loaded image.
    """
    img = Image.open(file_path)
    return np.array(img)


def is_navigable(pixel_value):
    """
        Checks if a pixel is navigable based on its color.
        :param pixel_value: The pixel value representing the color.
        :return: True if the pixel is navigable, False otherwise.
        :requires: Assumes a color scheme where black is considered not navigable.
        :ensures: Returns True if the pixel is navigable, and False otherwise.
    """
    # Assuming black is not navigable (change this condition as per your image)
    return not np.any(pixel_value < 30)


def is_valid(x, y, image, min_distance=5):
    """
        Checks if a given pixel position is valid within the image.
        :param x: The x-coordinate of the pixel.
        :param y: The y-coordinate of the pixel.
        :param image: The image in which the validity is checked.
        :param min_distance: The minimum distance requirement from black pixels.
        :return: True if the pixel position is valid, False otherwise.
        :requires: The image must be a valid NumPy array.
        :ensures: Returns True if the pixel position is valid, and False otherwise.
    """


    if 0 <= x < image.shape[0] and 0 <= y < image.shape[1]:
        # Check if the pixel is at least min_distance away from any black pixel
        region_around_pixel = image[max(0, x-min_distance):min(image.shape[0], x+min_distance+1),
                                    max(0, y-min_distance):min(image.shape[1], y+min_distance+1)]
        if not np.any(region_around_pixel == 0) and is_navigable(image[x, y]):
            return True
    return False

def astar(image, start, end):
    """
        Applies the A* algorithm to find a path in the image from start to end.
        :param image: The image on which the pathfinding is performed.
        :param start: The starting point (x, y) coordinates for the pathfinding.
        :param end: The ending point (x, y) coordinates for the pathfinding.
        :return: A list of (x, y) coordinates representing the path.
        :requires: The image must be a valid NumPy array.
                The start and end points must be valid coordinates within the image.
        :ensures: Returns a valid path from start to end in the image.
    """
    directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]

    def heuristic(a, b):
        return abs(a[0] - b[0]) + abs(a[1] - b[1])

    heap = [(0, start)]
    heapq.heapify(heap)
    came_from = {start: None}
    cost_so_far = {start: 0}

    while heap:
        current_cost, current_pos = heapq.heappop(heap)

        if current_pos == end:
            break

        for dx, dy in directions:
            next_pos = (current_pos[0] + dx, current_pos[1] + dy)
            new_cost = cost_so_far[current_pos] + 1

            if is_valid(*next_pos, image) and (next_pos not in cost_so_far or new_cost < cost_so_far[next_pos]):
                cost_so_far[next_pos] = new_cost
                priority = new_cost + heuristic(end, next_pos)
                heapq.heappush(heap, (priority, next_pos))
                came_from[next_pos] = current_pos

    path = []
    current = end
    while current:
        path.append(current)
        current = came_from[current]

    return path[::-1]  # Reverse the path to start from the beginning


def draw_path(image, path):
    """
        Draws the identified path on the image.
        :param image: The image on which the path is drawn.
        :param path: A list of (x, y) coordinates representing the path.
        :return: A modified image with the drawn path.
        :requires: The image must be a valid NumPy array.
                The path must be a valid list of coordinates.
        :ensures: Returns an image with the drawn path.
    """
    img = Image.fromarray(image)
    draw = ImageDraw.Draw(img)
    for x, y in path:
        draw.line((y, x, y+1, x+1), fill='red', width=7)  # Assuming 128 represents the path color
    img.show()
    return img


if __name__ == "__main__":
    image_path = "goodFloor3.png"
    image = load_image(image_path)

    start_point = (137, 281)
    end_point = (430, 390)

    path = astar(image, start_point, end_point)
    draw_path(image, path)
