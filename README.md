# Indoor Navigation System

This project is an Indoor Navigation System that uses image recognition and pathfinding algorithms to determine the shortest path between two points in a building. The backend is implemented in Python using Flask and Tensorflow, and the frontend is implemented in Dart using Flutter.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You need to have the following installed:

- Python 3.10 or lower
- Flutter SDK
- An IDE (like VS Code or Android Studio)

### Backend Setup

1. Clone the repo
   ```
   git clone https://github.com/your_username_/Project-Name.git
   ```
2. Navigate to the backend directory
   ```
   cd Backend
   ```
3. Create a virtual environment (optional)
   ```
   python3 -m venv env
   source env/bin/activate
   ```
4. Install the requirements
   ```
   pip install -r requirements.txt
   ```
5. Run the Flask API
   ```
   python app.py
   ```

### Frontend Setup

1. Navigate to the frontend directory
   ```
   cd indoornav
   ```
2. Update the `ipAddress` variable in the `CameraScreen.dart` file to the IP address of your Flask API
3. Get Flutter packages
   ```
   flutter pub get
   ```
4. Run the Flutter app
   ```
   flutter run
   ```

## Usage

The application works by taking a picture of a room number (the starting point) and a destination room number is inputted. The picture and the room number are sent to the Flask API for image analysis and pathfinding. The API returns an image showing the shortest path from the starting point to the destination.

## Files

Here is a brief explanation of the key files in the project:

- `app.py`: This is the main file that runs the Flask API. It receives the image and room number from the frontend, performs image analysis to extract the starting point, and uses a pathfinding algorithm to find the shortest path to the destination.

- `CameraScreen.dart`: This is the Flutter screen where the user can take a picture and input a destination room number. The picture and room number are sent to the Flask API.

- `MapScreen.dart`: This is the Flutter screen where the path image returned from the Flask API is displayed.

- `image_analysis.py`: This file contains functions for loading an image, checking if a pixel is navigable, checking if a pixel position is valid, applying the A* algorithm to find a path, and drawing the path on the image.

- `image_reader.py`: This file contains functions for extracting text from an image and finding a path in an image.

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are greatly appreciated.

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

Your Name - example@example.com

Project Link: [https://github.com/your_username/repo_name](https://github.com/your_username/repo_name)