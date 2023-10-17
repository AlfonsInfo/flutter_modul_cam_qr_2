import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modul_cam_qr_2/views/camera/display_picture.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});
  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  Future<void>? _initializeCameraFuture;
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _cameraController = CameraController(firstCamera,ResolutionPreset.medium);
    _initializeCameraFuture = _cameraController.initialize();
    if (mounted) {
      setState(() {});
    }
  }


  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //_cameraController == null
    if (_initializeCameraFuture == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      body: FutureBuilder<void>(
        future: _initializeCameraFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraController);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await previewImageResult(),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }


  Future<DisplayPictureScreen?> previewImageResult () async
  {
    try {
      await _initializeCameraFuture;
      final image = await _cameraController.takePicture();
      if(!mounted) return null;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) 
          { 
            debugPrint(image.path);
            return DisplayPictureScreen(imagePath: image.path);
            },
          ),
      );
    } catch (e) {
      return null;
    }
    return null;
  }
}

