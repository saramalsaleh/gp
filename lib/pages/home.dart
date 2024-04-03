import 'package:gp/constans/app_color.dart';
import 'package:gp/widgets/app_background.dart';
import 'package:gp/widgets/app_button.dart';
import 'package:gp/widgets/star_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'question_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackGround(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [ SizedBox(height:4),
            const Align(
              alignment: Alignment.topRight,
              child: StarCount(),
            ),
            Expanded(
              child: Stack(
                children: [
                  PositionedDirectional(
                    top: MediaQuery.of(context).size.height * 0.02,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/happy.svg',
                          height: 200,
                        ),
                        const Text(
                          'Happy',
                          style: TextStyle(
                            fontSize: 44,
                            fontFamily: 'ribeye',
                            color: AppColor.greenColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    top: MediaQuery.of(context).size.height * 0.25,
                    end: 0,
                    child: Row(
                      children: [
                        const Text(
                          'Sad',
                          style: TextStyle(
                            fontSize: 44,
                            fontFamily: 'ribeye',
                            color: AppColor.yellowColor,
                          ),
                        ),
                        const SizedBox(width: 44),
                        SvgPicture.asset(
                          'assets/images/sad.svg',
                          height: 170,
                        ),
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    top: MediaQuery.of(context).size.height * 0.43,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/angry.svg',
                          height: 200,
                        ),
                        const Text(
                          'Angry',
                          style: TextStyle(
                            fontSize: 44,
                            fontFamily: 'ribeye',
                            color: AppColor.redColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppButton(
                onPressed: () {},
                title: 'take picture',
                backgroundColor: AppColor.tealColor),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
              width: double.infinity,
            ),
            AppButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuestionPage(),
                      ));
                },
                title: 'see and answer',
                backgroundColor: AppColor.pinkColor),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}