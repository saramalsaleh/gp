import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:gp/pages/takePicture/model.dart';
import 'package:image_picker/image_picker.dart';

import '../../constans/app_color.dart';
import '../../constans/utils.dart';
import '../../widgets/star_count.dart';
import '../result_page.dart';

class TakePictureController {
  final notifier = ValueNotifier<int>(0);

  void _update() => notifier.value = notifier.value + 1;
  String? _imageLabel;
  String answer = '';
  String? imagePath;
  final _picker = ImagePicker();
  late ImageLabeler _imageLabeler;
  bool _canProcess = false;
  bool _isBusy = false;

  TakePictureController() {
    answer = randomQuestion;
    _initializeLabeler();
  }

  void _initializeLabeler() async {
    // uncomment next line if you want to use the default model
    // _imageLabeler = ImageLabeler(options: ImageLabelerOptions());

    _imageLabeler = await getModel();

    _canProcess = true;
  }

  Future<void> _processImage(InputImage inputImage) async {
    
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;

    final sp = Stopwatch()..start();
    final labels = await _imageLabeler.processImage(inputImage);

    labels.sort((a, b) => b.confidence.compareTo(a.confidence));
    _imageLabel = labels.first.label.toLowerCase();

    _isBusy = false;
    print("@TIME :${sp.elapsedMilliseconds}");
  }

  Color getColor() {
    if (answer == 'Angry') return AppColor.redColor;
    if (answer == 'Sad') return AppColor.greenColor;
    return AppColor.yellowColor;
  }

  void pickImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image?.path == null) return;

    imagePath = image?.path;
    _update();

    _processImage(
      InputImage.fromFilePath(imagePath!),
    );
  }

  void showResult( BuildContext context) {
    final isCorrect =
        answer.toLowerCase() == _imageLabel || 'other' == _imageLabel;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          isCorrect: isCorrect,
        ),
      ),
    );

    if (isCorrect) {
      Future.delayed(const Duration(milliseconds: 20))
          .then((_) => StarCount.increment());
    }
  }
  void dispose() {
    _canProcess = false;
    _imageLabeler.close();
  }
}
