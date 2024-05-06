import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:gp/constans/app_color.dart';
import 'package:gp/constans/utils.dart';
import 'package:gp/pages/result_page.dart';
import 'package:gp/widgets/app_background.dart';
import 'package:gp/widgets/app_button.dart';
import 'package:gp/widgets/shadow.dart';
import 'package:gp/widgets/star_count.dart';
import 'package:image_picker/image_picker.dart';

class TakePictureAiPage extends StatefulWidget {
  const TakePictureAiPage({super.key});

  @override
  State<TakePictureAiPage> createState() => _TakePictureAiPageState();
}

class _TakePictureAiPageState extends State<TakePictureAiPage> {
  String? _imageLabel;

  String _answer = '';
  String? imagePath;

  final _picker = ImagePicker();

  late ImageLabeler _imageLabeler;
  bool _canProcess = false;
  bool _isBusy = false;

  @override
  void initState() {
    _answer = randomQuestion;

    super.initState();
    _initializeLabeler();
  }

  @override
  void dispose() {
    _canProcess = false;
    _imageLabeler.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackGround(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_outlined)),
                const StarCount(),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      FlutterTts().speak(_answer);
                    },
                    child: Center(
                      child: Text(
                        _answer,
                        style: TextStyle(
                          fontSize: 44,
                          fontFamily: 'ribeye',
                          color: getColor(_answer),
                          shadows: textShadow,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final image = await _picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image?.path == null) return;

                      setState(() => imagePath = image?.path);

                      _processImage(
                        InputImage.fromFilePath(imagePath!),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ShadowWidget(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey.shade300,
                            ),
                            height: 300,
                            width: 300,
                            child: (imagePath == null)
                                ? null
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.file(
                                          File(imagePath!),
                                          height: 280,
                                          width: 280,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        Icon(
                          Icons.camera_enhance_rounded,
                          color: AppColor.tealColor
                              .withOpacity(imagePath != null ? 0.6 : 1),
                          size: 120,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 42),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: imagePath == null
                          ? const SizedBox()
                          : InkWell(
                              onTap: () {
                                final isCorrect =
                                    _answer.toLowerCase() == _imageLabel ||
                                        'other' == _imageLabel;

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResultPage(
                                      isCorrect: isCorrect,
                                    ),
                                  ),
                                );

                                if (isCorrect) {
                                  Future.delayed(
                                          const Duration(milliseconds: 20))
                                      .then((_) => StarCount.increment());
                                }
                              },
                              child: const ShadowWidget.image(
                                child: IgnorePointer(
                                  child: AppButton(
                                    title: 'CONTINUE',
                                    icon: Padding(
                                      padding: EdgeInsets.only(top: 6),
                                      child: Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: AppColor.pinkColor,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getColor(String label) {
    if (label == 'Angry') return AppColor.redColor;
    if (label == 'Sad') return AppColor.greenColor;
    return AppColor.yellowColor;
  }

  void _initializeLabeler() async {
    // uncomment next line if you want to use the default model
    // _imageLabeler = ImageLabeler(options: ImageLabelerOptions());
    const path = 'assets/ml/model.tflite';
    final modelPath = await getAssetPath(path);
    final options = LocalLabelerOptions(
      modelPath: modelPath,
      confidenceThreshold: 0.1,
    );
    _imageLabeler = ImageLabeler(options: options);

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
    print ("@TIME :${sp.elapsedMilliseconds}" );
    
  }
}