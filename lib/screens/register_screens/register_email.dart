import 'package:banking_app/services/auth_service.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:banking_app/widgets/info.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import '../../models/user_model.dart';
import 'register_username.dart';

import '../../widgets/app_button.dart';

class RegisterEmail extends StatefulWidget {
  const RegisterEmail({super.key});

  @override
  State<RegisterEmail> createState() => _RegisterEmailState();
}

class _RegisterEmailState extends State<RegisterEmail> {
  final _emailController = TextEditingController();
  bool _isValid = false;
  bool _isEmailAvailable = false;

  Future<void> _validateEmail(String email) async {
    bool isValid = EmailValidator.validate(email);
    _isEmailAvailable = await AuthService().checkEmail(email);

    setState(() {
      _isValid = isValid;
    });
  }

  bool _checkEmail() {
    return _isEmailAvailable && _isValid;
  }

  // Future<void> _checkEmail(String email) async {
  //   _isEmailAvailable = await AuthService().checkEmail(email);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.register),
        actions: const [Info()],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: 1 / 4,
            color: AppColors.baseColor,
            minHeight: Sizes.size8,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: Sizes.size12, bottom: Sizes.size16),
                        child: Text(
                          Strings.email,
                          style: TextStyle(fontSize: Sizes.size32),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: Sizes.size12, bottom: Sizes.size32),
                        child: Text(
                          Strings.emailDesc,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: Sizes.size380,
                          child: TextField(
                            controller: _emailController,
                            onChanged: (value) {
                              _validateEmail(_emailController.text);
                            },
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: Strings.email,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Sizes.size50,
                  ),
                  _checkEmail()
                      ? const SizedBox.shrink()
                      : const Text(
                          'not available',
                          style: TextStyle(color: Colors.red),
                        ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: Sizes.size55),
                    child: AppButton(
                      title: Strings.next,
                      isValid: _checkEmail(),
                      onTap: () {
                        Provider.of<UserModel>(context, listen: false).setEmail(_emailController.text);
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (context) => const RegisterUsername()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
