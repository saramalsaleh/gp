import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gp/constans/app_color.dart';
import 'package:gp/constans/utils.dart';
import 'package:gp/pages/result_page.dart';
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
  String _correctAnswer = '';
  String _selectedAnswer = '';
  String _image = '';
  final tts = FlutterTts();

  @override
  void initState() {
    _correctAnswer = randomQuestion;
    _image =
        'assets/images/quiz/${_correctAnswer.toLowerCase()}/${Random().nextInt(2) + 1}.jpg';
    super.initState();
  }

  void selectAnswer(String text) async {
    tts.speak(text);
    setState(() => _selectedAnswer = text);

    final isCorrect = _selectedAnswer == _correctAnswer;
    await Future.delayed(const Duration(seconds: 1));

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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ShadowWidget.image(child: Image.asset(_image, height: 280)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppButton(
                        onPressed: () {
                          selectAnswer('Happy');
                        },
                        title: 'happy'.toUpperCase(),
                        selected: _selectedAnswer == 'Happy',
                        backgroundColor: AppColor.yellowColor,
                      ),
                      const SizedBox(height: 32),
                      AppButton(
                        onPressed: () {
                          selectAnswer('Sad');
                        },
                        title: 'sad'.toUpperCase(),
                        selected: _selectedAnswer == 'Sad',
                        backgroundColor: AppColor.greenColor,
                      ),
                      const SizedBox(height: 20),
                      AppButton(
                        onPressed: () {
                          selectAnswer('Angry');
                        },
                        title: 'angry'.toUpperCase(),
                        selected: _selectedAnswer == 'Angry',
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
    }
}