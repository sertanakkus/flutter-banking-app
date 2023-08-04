import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: Sizes.size89, bottom: Sizes.size40),
            child: Image.asset(
              ImagePaths.onboarding2,
              width: Sizes.size200,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size50),
            child: Text(
              Strings.onboarding2Title,
              style: TextStyle(
                fontSize: Sizes.size24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Sizes.size16, right: Sizes.size50, left: Sizes.size50),
            child: Text(
              Strings.onboarding2Description,
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
