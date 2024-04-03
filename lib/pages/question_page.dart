import 'package:gp/constans/app_color.dart';
import 'package:gp/widgets/app_background.dart';
import 'package:gp/widgets/app_button.dart';
import 'package:gp/widgets/star_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({super.key});

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  'assets/images/happy_person.svg',
                ),
                const SizedBox(
                  height: 30,
                ),
                AppButton(
                    onPressed: () {},
                    title: 'sad'.toUpperCase(),
                    backgroundColor: AppColor.greenColor),
                const SizedBox(
                  height: 20,
                ),
                AppButton(
                    onPressed: () {},
                    title: 'happy'.toUpperCase(),
                    backgroundColor: AppColor.yellowColor),
                const SizedBox(
                  height: 20,
                ),
                AppButton(
                    onPressed: () {},
                    title: 'angry'.toUpperCase(),
                    backgroundColor: AppColor.redColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}