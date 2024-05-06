import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gp/constans/app_color.dart';
import 'package:gp/widgets/add_to_cart_icon.dart';
import 'package:gp/widgets/app_background.dart';
import 'package:gp/widgets/app_button.dart';
import 'package:gp/widgets/shadow.dart';
import 'package:gp/widgets/star_count.dart';

class ResultPage extends StatefulWidget {
  final bool isCorrect;

  const ResultPage({super.key, required this.isCorrect});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AssetsAudioPlayer.newPlayer().open(
        Audio(
            'assets/audios/${widget.isCorrect ? 'Kids_Cheering.mp3' : 'try_again.mp3'}'),
      );
      if (widget.isCorrect) await runAddToCartAnimation(widgetKey);
    });

    super.initState();
  }

  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  final widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      createAddToCartAnimation: (runAddToCartAnimation) {
        // You can run the animation by addToCartAnimationMethod, just pass trough the the global key of  the image as parameter
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      opacity: 1,
      dragAnimation: const DragToCartAnimationOptions(
        rotation: true,
      ),
      jumpAnimation: const JumpAnimationOptions(),
      child: AppBackGround(
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
                  AddToCartIcon(
                    key: cartKey,
                    icon: StarCount(isAnimate: widget.isCorrect),
                  )
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ShadowWidget.image(
                      child: SvgPicture.asset(
                        'assets/images/result_complete_${widget.isCorrect?"correct":"wrong"}.svg',
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ShadowWidget.image(
                          child: SvgPicture.asset(
                            'assets/images/result_${widget.isCorrect ? 'correct' : 'wrong'}.svg',
                          ),
                        ),
                        Opacity(
                          opacity: 0,
                          child: Container(
                            key: widgetKey,
                            child: SvgPicture.asset(
                              'assets/images/star.svg',
                              height: 120,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(),
                    AppButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      title: 'Close'.toUpperCase(),
                      backgroundColor: AppColor.pinkColor,
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}