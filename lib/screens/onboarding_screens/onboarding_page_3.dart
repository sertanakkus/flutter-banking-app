import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: Sizes.size70, bottom: Sizes.size40),
            child: Image.asset(
              ImagePaths.onboarding3,
              width: 328,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size50),
            child: Text(
              Strings.onboarding3Title,
              style: TextStyle(
                fontSize: Sizes.size24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Sizes.size16, right: Sizes.size50, left: Sizes.size50),
            child: Text(
              Strings.onboarding3Description,
              style: const TextStyle(color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
