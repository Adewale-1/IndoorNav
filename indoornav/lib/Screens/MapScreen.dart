import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  static const String id = 'MapScreen';

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String? base64Image;
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    if (args != null && args['base64Image'] != null) {
      base64Image = args['base64Image'];
      decodeBase64(base64Image!);
    }
  }

  Future<void> decodeBase64(String base64Image) async {
    await Future.delayed(Duration.zero);
    final bytes = base64Decode(base64Image);
    setState(() {
      this.imageBytes = bytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (imageBytes == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Center(
        child: Container(
          // Display the image
          child: Image.memory(imageBytes!),
        ),
      ),
    );
  }
}
