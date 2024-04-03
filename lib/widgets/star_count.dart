import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StarCount extends StatelessWidget {
  const StarCount({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SvgPicture.asset(
          'assets/images/stars.svg',
        ),
        const PositionedDirectional(
          start: 50.0,
          child: Text('21',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'ribeye',
              )),
        ),
      ],
    );
  }
}