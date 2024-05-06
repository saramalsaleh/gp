import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

const textShadow = [
  Shadow(
    color: Colors.black26, // Choose the color of the first shadow
    blurRadius: 2.0, // Adjust the blur radius for the first shadow effect
    offset: Offset(2.0,
        2.0), // Set the horizontal and vertical offset for the first shadow
  ),
];

String get randomQuestion => ['Angry', 'Sad', 'Happy'][Random().nextInt(3)];

Future<String> getAssetPath(String asset) async {
  final path = await getLocalPath(asset);
  await Directory(dirname(path)).create(recursive: true);
  final file = File(path);
  if (!await file.exists()) {
    final byteData = await rootBundle.load(asset);
    await file.writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );
  }
  return file.path;
}

Future<String> getLocalPath(String path) async {
  return '${(await getApplicationSupportDirectory()).path}/$path';
}
