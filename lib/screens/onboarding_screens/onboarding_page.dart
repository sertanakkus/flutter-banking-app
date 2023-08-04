import 'package:banking_app/widgets/onboarding_app_bar.dart';

import '../../utils/constants.dart';
import '../../widgets/app_button.dart';
import '../login_screen.dart';
import 'onboarding_page_1.dart';
import 'onboarding_page_2.dart';
import 'onboarding_page_3.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController controller = PageController();

  final List<Widget> _list = <Widget>[
    const OnboardingPage1(),
    const OnboardingPage2(),
    const OnboardingPage3(),
  ];
  int curr = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OnboardingAppBar(),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              allowImplicitScrolling: true,
              scrollDirection: Axis.vertical,
              // reverse: true,
              // physics: BouncingScrollPhysics(),
              controller: controller,
              onPageChanged: (num) {
                setState(() {
                  curr = num;
                });
              },
              children: _list,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: Sizes.size40, left: Sizes.size16, right: Sizes.size16),
              child: AppButton(
                title: Strings.getStarted,
                isValid: true,
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
              )),
        ],
      ),
    );
  }

  onPressed(context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
