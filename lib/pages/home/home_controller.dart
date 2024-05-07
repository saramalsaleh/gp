
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../question/question_page.dart';
import '../takePicture/takePicture_page..dart';

class HomeController{
  final tts = FlutterTts();
  final saying = <String>{};
  final notifier = ValueNotifier<int>(0);
  void _update() => notifier.value = notifier.value + 1;

  void say( String text )async {
     saying.add(text);
     _update();
    tts.speak(text);
    await Future.delayed(
        const Duration(milliseconds: 1400));
    saying.remove(text);
    _update();
  }
  void goToTakePicture(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TakePictureAiPage(),
      ),
    );
  }

  void goToQuestion(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QuestionPage(),
      ),
    );
  }
}