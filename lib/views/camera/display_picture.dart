import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_modul_cam_qr_2/utils/logging_utils.dart';


class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath}): super(key: key);

  @override
  Widget build(BuildContext context) {
    LoggingUtils.logStartFunction("Build DisplayPictureScreen");
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}