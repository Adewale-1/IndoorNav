import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:indoornav/Screens/MapScreen.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  static const String id = 'CameraScreen';

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late List<CameraDescription> camera;
  bool _isControllerInitialized = false;
  bool _isPictureTaken = false;

  String ipAddress = 'add_your_ip_address_and_port_here';
  String userInput = "";
  @override
  void initState() {
    super.initState();
    initCamera();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDialog();
    });
  }

  void _Map() {
    Navigator.pushNamed(context, MapScreen.id);
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Room Number'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                userInput = value;
              });
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /*
     * Initializes the camera controller and sets the [_isControllerInitialized] flag.
     *
     * @requires The [camera] variable must be initialized with available cameras.
     * @ensures The [_controller] is initialized with the first camera in [camera].
     *          The [_isControllerInitialized] flag is set to true if the initialization is successful.
  */
  Future<void> initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    camera = await availableCameras();
    _controller = CameraController(camera[0], ResolutionPreset.max);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isControllerInitialized =
            true; // Set to true when initialization is complete
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print("Access was denied");
            break;
          default:
            print(e.description);
            break;
        }
      }
    });
  }

  void _captureImage() async {
    if (!_controller.value.isInitialized) {
      return null;
    }
    if (_controller.value.isTakingPicture) {
      return null;
    }
    try {
      await _controller.setFlashMode(FlashMode.auto);
      XFile picture = await _controller.takePicture();

      // Save the picture to a file
      final String dir = (await getTemporaryDirectory()).path;
      final String path = '$dir/picture.jpg';
      await picture.saveTo(path);

      print('--->>>>>>>>>Image saved at: $path');
      print('--->>>>>>>>>');
      print('--->>>>>>>>>');
      print('--->>>>>>>>>');
      print('--->>>>>>>>>');
      print(userInput);

      // Convert the image file to base64
      final bytes = File(path).readAsBytesSync();
      String img64 = base64Encode(bytes);

      _Map();
      // Send the base64 image to your backend
      try {
        var response = await http.post(
          Uri.parse(ipAddress), // Updated the URL
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'image': img64,
            'room_number': userInput,
          }),
        );
        print(response.body);

        if (response.statusCode == 200) {
          print('Picture uploaded');
          setState(() {
            _isPictureTaken = true; // Set to true when picture is taken
          });
          // Navigate to MapScreen and pass the base64 string
          Navigator.pushNamed(context, MapScreen.id,
              arguments: {'base64Image': response.body});
        } else {
          print('Failed to upload picture');
          print(
              'Response body: ${response.body}'); // print out the response body
        }
      } catch (e) {
        print('Failed to upload picture: $e');
      }
    } on CameraException catch (e) {
      debugPrint("Error occurred while taking picture");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isControllerInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              child: CameraPreview(_controller),
            ),
            // Show a message if picture is taken
            if (_isPictureTaken)
              const Center(
                child: Text(
                  "Picture taken!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
          ],
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            onPressed: _captureImage,
            child: const Icon(Icons.camera),
          ),
        ),
      );
    }
  }
}
