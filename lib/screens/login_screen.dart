import 'package:banking_app/screens/register_screens/register_main.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:banking_app/widgets/app_button.dart';
import 'package:banking_app/widgets/onboarding_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String emailUsername = '';
  String password = '';

  final _emailUsernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void assignValues() {
    setState(() {
      emailUsername = _emailUsernameController.text;
      password = _passwordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OnboardingAppBar(),
      body: Column(
        children: [
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
                        Strings.welcome,
                        style: TextStyle(fontSize: Sizes.size32),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: Sizes.size12, bottom: Sizes.size32),
                  child: Text(
                    Strings.loginDesc,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: Sizes.size380,
                        child: TextField(
                          controller: _emailUsernameController,
                          onChanged: (value) => assignValues(),
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: Strings.emailUsername,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Sizes.size16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: Sizes.size380,
                          child: TextField(
                            controller: _passwordController,
                            onChanged: (value) => assignValues(),
                            obscureText: true,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: Strings.password,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [const Checkbox(value: false, onChanged: null), Text(Strings.rememberMe)],
                    ),
                    Text(
                      Strings.forgotPassword,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: Sizes.size32),
                  child: AppButton(
                    isValid: true,
                    title: 'Login',
                    onTap: () {
                      AuthService().signIn(context, username: emailUsername, email: emailUsername, password: password);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Sizes.size16),
                  child: Text(
                    Strings.other,
                  ),
                ),
                const LoginWithGmail(),
              ],
            ),
          ),
          const Spacer(),
          Padding(
              padding: EdgeInsets.only(bottom: Sizes.size40),
              child: RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(text: Strings.haveAccount, style: const TextStyle(color: Colors.black)),
                TextSpan(
                  text: Strings.register,
                  style: TextStyle(color: AppColors.baseColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        )),
                ),
              ]))),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Sizes.size32),
      child: SizedBox(
        width: double.infinity,
        height: Sizes.size53,
        child: ElevatedButton(
          onPressed: null,
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppColors.baseColor),
              foregroundColor: const MaterialStatePropertyAll(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.size8)))),
          child: Text(
            Strings.login,
          ),
        ),
      ),
    );
  }
}

class LoginWithGmail extends StatelessWidget {
  const LoginWithGmail({
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
              Text(Strings.loginGmail)
            ],
          )),
    );
  }
}
