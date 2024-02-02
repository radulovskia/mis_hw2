import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  int direction = 0;

  @override
  void initState() {
    startCamera(direction);
    super.initState();
  }

  void startCamera(int direction) async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );
    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _takePicture() async {
    try {
      final XFile? file = await cameraController.takePicture();

      if (file != null) {
        // Get the directory for the gallery
        final Directory? galleryDirectory = await getExternalStorageDirectory();

        // Construct the new file path in the gallery directory
        final String fileName = path.basename(file.path);
        final String galleryPath = path.join(galleryDirectory!.path, fileName);

        // Move the picture file to the gallery
        await File(file.path).copy(galleryPath);

        print("Picture saved to $galleryPath");
      }
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(title: const Text('Camera')),
        body: Stack(
          children: [
            CameraPreview(cameraController),
            GestureDetector(
                onTap: () {
                  setState(() {
                    direction = direction == 0 ? 1 : 0;
                    startCamera(direction);
                  });
                },
                child: button(
                    Icons.flip_camera_ios_outlined, Alignment.bottomLeft)),
            GestureDetector(
                onTap: () {
                  _takePicture();
                  // cameraController.takePicture().then((XFile? file) {
                  //   if (mounted && file != null) {
                  //     print("Picture saved to ${file.path}");
                  //   }
                  // });
                },
                child:
                    button(Icons.camera_alt_outlined, Alignment.bottomCenter)),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget button(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
