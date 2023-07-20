import 'package:banking_app/screens/register_screens/register_email.dart';
import 'package:banking_app/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OnboardingAppBar(),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: Sizes.size12),
                    child: Text(
                      Strings.register,
                      style: TextStyle(fontSize: Sizes.size32),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: Sizes.size12, bottom: Sizes.size32),
                child: Text(
                  Strings.registerDesc,
                  style: const TextStyle(color: Colors.black54),
                ),
              ),
              const RegisterWithGmail(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Sizes.size16),
                child: Text(
                  Strings.other,
                ),
              ),
              const RegisterWithEmailButton(),
            ],
          ),
        ),
      ]),
    );
  }
}

class RegisterWithGmail extends StatelessWidget {
  const RegisterWithGmail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.size53,
      child: ElevatedButton(
          onPressed: null,
          style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
              foregroundColor: const MaterialStatePropertyAll(Colors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.size8), side: const BorderSide(color: Colors.black12)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(Sizes.size8),
                child: Image.asset(
                  ImagePaths.googleIcon,
                  width: Sizes.size16,
                ),
              ),
              Text(Strings.registerGmail)
            ],
          )),
    );
  }
}

class RegisterWithEmailButton extends StatelessWidget {
  const RegisterWithEmailButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Sizes.size53,
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const RegisterEmail(),
        )),
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Color(0XFF05BE71)),
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.size8)))),
        child: Text(
          Strings.registerEmail,
        ),
      ),
    );
  }
}
