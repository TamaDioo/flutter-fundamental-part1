import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kamera_filter_carousel/widgets/takepicture_screen.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Dapatkan kamera pertama dari daftar (biasanya kamera belakang)
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      // Pass the appropriate camera to the TakePictureScreen widget.
      home: TakePictureScreen(camera: firstCamera),
      debugShowCheckedModeBanner: false,
    ),
  );
}
