import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gp/constans/app_color.dart';
import 'package:gp/constans/utils.dart';
import 'package:gp/pages/home/home_controller.dart';
import 'package:gp/widgets/app_background.dart';
import 'package:gp/widgets/app_button.dart';
import 'package:gp/widgets/pulse_animation.dart';
import 'package:gp/widgets/shadow.dart';
import 'package:gp/widgets/star_count.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, _, __) {
        return AppBackGround(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/app_name.png',
                      height: 40,
                      color: const Color(0xff99300e),
                    ),
                    const StarCount(),
                  ],
                ),
                Expanded(
                  child: Stack(
                    children: [
                      PositionedDirectional(
                        top: MediaQuery.of(context).size.height * 0.02,
                        child: Row(
                          children: [
                            ShadowWidget.image(
                              child: SvgPicture.asset(
                                'assets/images/happy.svg',
                                height: 200,
                              ).pulse(
                                  show: controller.saying.contains('happy')),
                            ),
                            InkWell(
                              onTap: () async {
                                controller.say('happy');
                              },
                              child: const Text(
                                'Happy',
                                style: TextStyle(
                                  fontSize: 38,
                                  fontFamily: 'ribeye',
                                  color: AppColor.yellowColor,
                                  shadows: textShadow,
                                ),
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
                            InkWell(
                              onTap: () async {
                                controller.say('Sad');
                              },
                              child: const Text(
                                'Sad',
                                style: TextStyle(
                                  fontSize: 38,
                                  fontFamily: 'ribeye',
                                  color: AppColor.greenColor,
                                  shadows: textShadow,
                                ),
                              ),
                            ),
                            const SizedBox(width: 44),
                            ShadowWidget.image(
                              child: SvgPicture.asset(
                                'assets/images/sad.svg',
                                height: 170,
                              ).pulse(show: controller.saying.contains('Sad')),
                            ),
                          ],
                        ),
                      ),
                      PositionedDirectional(
                        top: MediaQuery.of(context).size.height * 0.43,
                        child: Row(
                          children: [
                            ShadowWidget.image(
                              child: SvgPicture.asset(
                                'assets/images/angry.svg',
                                height: 200,
                              ).pulse(
                                  show: controller.saying.contains('Angry')),
                            ),
                            InkWell(
                              onTap: () async {
                                controller.say('Angry');
                              },
                              child: const Text(
                                'Angry',
                                style: TextStyle(
                                  fontSize: 38,
                                  fontFamily: 'ribeye',
                                  color: AppColor.redColor,
                                  shadows: textShadow,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AppButton(
                  onPressed: () {
                    controller.goToTakePicture(context);
                  },
                  title: 'take a picture',
                  icon: const Padding(
                    padding: EdgeInsets.only(top: 6, left: 6),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: AppColor.tealColor,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                  width: double.infinity,
                ),
                AppButton(
                    onPressed: () {
                      controller.goToQuestion(context);
                    },
                    title: 'see and answer',
                    icon: const Icon(
                      Icons.question_mark_rounded,
                      color: Colors.white,
                    ),
                    backgroundColor: AppColor.pinkColor),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ],
            ),
          ),
        );
      },
      valueListenable: controller.notifier,
    );
  }
}
