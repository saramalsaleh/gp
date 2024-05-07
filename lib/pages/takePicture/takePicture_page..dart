import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gp/constans/app_color.dart';
import 'package:gp/constans/utils.dart';
import 'package:gp/pages/takePicture/takePicture_controller.dart';
import 'package:gp/widgets/app_background.dart';
import 'package:gp/widgets/app_button.dart';
import 'package:gp/widgets/shadow.dart';
import 'package:gp/widgets/star_count.dart';

class TakePictureAiPage extends StatefulWidget {
  const TakePictureAiPage({super.key});

  @override
  State<TakePictureAiPage> createState() => _TakePictureAiPageState();
}

class _TakePictureAiPageState extends State<TakePictureAiPage> {
  final controller = TakePictureController();

  @override
  void dispose() {
    controller.dispose();
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
                      FlutterTts().speak(controller.answer);
                    },
                    child: Center(
                      child: Text(
                        controller.answer,
                        style: TextStyle(
                          fontSize: 44,
                          fontFamily: 'ribeye',
                          color: controller.getColor(),
                          shadows: textShadow,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      controller.pickImage();
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
                            child: (controller.imagePath == null)
                                ? null
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.file(
                                          File(controller.imagePath!),
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
                          color: AppColor.tealColor.withOpacity(
                              controller.imagePath != null ? 0.6 : 1),
                          size: 120,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 42),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: controller.imagePath == null
                          ? const SizedBox()
                          : InkWell(
                              onTap: () {
                                controller.showResult(context);
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
}
