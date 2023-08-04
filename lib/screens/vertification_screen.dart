import 'package:banking_app/screens/onboarding_screens/onboarding_page.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/app_button.dart';

class VertificationScreen extends StatefulWidget {
  const VertificationScreen({super.key});

  @override
  State<VertificationScreen> createState() => _VertificationScreenState();
}

class _VertificationScreenState extends State<VertificationScreen> {
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _focusNextField(int currentIndex) {
    if (currentIndex < _focusNodes.length - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[currentIndex + 1]);
    }
  }

  bool _isValid = false;

  void _validateVertificationCode() {
    late bool isValid = false;
    if (_controllers[0].text == '1' &&
        _controllers[1].text == '2' &&
        _controllers[2].text == '3' &&
        _controllers[3].text == '4') {
      isValid = true;
    }

    setState(() {
      _isValid = isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.verify),
        actions: [
          Center(
              child: IconButton(
            onPressed: () => print('info button'),
            icon: const Icon(Icons.info_outline),
            iconSize: 30,
          ))
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.size72),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: Sizes.size40, bottom: Sizes.size16),
                    child: Image.asset(
                      ImagePaths.message,
                      width: Sizes.size60,
                    ),
                  ),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(text: Strings.verifyDesc, style: const TextStyle(color: Colors.black)),
                    TextSpan(
                      text: "+62 855 - 9729 - 8172",
                      style: TextStyle(color: AppColors.baseColor),
                    ),
                  ])),
                  Padding(
                    padding: EdgeInsets.only(top: Sizes.size32, bottom: Sizes.size40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(4, (index) {
                        return SizedBox(
                          width: Sizes.size40,
                          height: Sizes.size40,
                          child: TextField(
                            textAlign: TextAlign.center,
                            obscureText: true,
                            obscuringCharacter: '*',
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                _focusNextField(index);
                                _validateVertificationCode();
                              }
                            },
                            decoration: const InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const Text('Resend 1:00'),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: Sizes.size55, right: Sizes.size16, left: Sizes.size16),
              child: AppButton(
                title: Strings.finish,
                isValid: _isValid,
                onTap: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) => const OnboardingPage()));
                },
                // targetWidget: const OnboardingPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
