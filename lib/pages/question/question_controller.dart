import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../constans/utils.dart';
import '../../widgets/star_count.dart';
import '../result_page.dart';

class QuestionController {
  String _correctAnswer = '';
  String selectedAnswer = '';
  String image = '';
  final tts = FlutterTts();
  final notifier = ValueNotifier<int>(0);

  void _update() => notifier.value = notifier.value + 1;

  QuestionController() {
    _correctAnswer = randomQuestion;
    image =
        'assets/images/quiz/${_correctAnswer.toLowerCase()}/${Random().nextInt(2) + 1}.jpg';
  }

  void selectAnswer(String text, BuildContext context) async {
    tts.speak(text);
    selectedAnswer = text;
    _update();

    final isCorrect = selectedAnswer == _correctAnswer;
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
}
