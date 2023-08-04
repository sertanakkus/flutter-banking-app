import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(top: Sizes.size38),
                child: Stack(children: [
                  Padding(
                      padding: EdgeInsets.only(top: Sizes.size67),
                      child: Image.asset(
                        ImagePaths.onboarding1_2,
                        width: 250,
                      )),
                  Image.asset(
                    ImagePaths.onboarding1_1,
                    width: 200,
                  ),
                ])),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: Sizes.size29),
          child: Padding(
            padding: EdgeInsets.only(bottom: Sizes.size16),
            child: Center(
              child: Text(
                Strings.onboarding1Title,
                style: TextStyle(fontSize: Sizes.size24),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: Sizes.size70, left: Sizes.size70, bottom: Sizes.size32),
          child: Text(
            Strings.onboarding1Description,
            style: TextStyle(fontSize: Sizes.size12, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ),
        Center(
          child: Column(
            children: [
              Text(Strings.swipe),
              Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.baseColor,
              )
            ],
          ),
        ),
      ],
    );
  }
}
