
import 'package:flutter/material.dart';
import 'package:gp/constans/app_color.dart';
import 'package:gp/pages/question/question_controller.dart';
import 'package:gp/widgets/app_background.dart';
import 'package:gp/widgets/app_button.dart';
import 'package:gp/widgets/shadow.dart';
import 'package:gp/widgets/star_count.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final controller = QuestionController();
  

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context,_,__) {
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ShadowWidget.image(child: Image.asset(controller.image, height: 280)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppButton(
                            onPressed: () {
                              controller.selectAnswer('Happy',context);
                            },
                            title: 'happy'.toUpperCase(),
                            selected: controller.selectedAnswer == 'Happy',
                            backgroundColor: AppColor.yellowColor,
                          ),
                          const SizedBox(height: 32),
                          AppButton(
                            onPressed: () {
                              controller.selectAnswer('Sad',context);
                            },
                            title: 'sad'.toUpperCase(),
                            selected: controller.selectedAnswer == 'Sad',
                            backgroundColor: AppColor.greenColor,
                          ),
                          const SizedBox(height: 20),
                          AppButton(
                            onPressed: () {
                              controller.selectAnswer('Angry',context);
                            },
                            title: 'angry'.toUpperCase(),
                            selected: controller.selectedAnswer == 'Angry',
                            backgroundColor: AppColor.redColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }, valueListenable: controller.notifier,
    );
    }
}