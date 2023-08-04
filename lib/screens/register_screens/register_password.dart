import 'package:banking_app/screens/register_screens/register_phone.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:banking_app/widgets/info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../widgets/app_button.dart';

class RegisterPassword extends StatefulWidget {
  const RegisterPassword({super.key});

  @override
  State<RegisterPassword> createState() => _RegisterEmailState();
}

class _RegisterEmailState extends State<RegisterPassword> {
  final _passwordController = TextEditingController();
  final _passwordController2 = TextEditingController();
  bool _isValid = false;

  void _validatePassword(String password, String rePassword) {
    bool isValid = password.length >= 6 && (rePassword == password);
    setState(() {
      _isValid = isValid;
    });
  }

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
            value: 3 / 4,
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
                          Strings.password,
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
                          Strings.passwordDesc,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(child: InputTextField(labelText: Strings.password, isRePasssword: false)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: Sizes.size16),
                          child: InputTextField(labelText: Strings.rePassword, isRePasssword: true),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: Sizes.size55),
                    child: AppButton(
                      title: Strings.next,
                      isValid: _isValid,
                      onTap: () {
                        Provider.of<UserModel>(context, listen: false).setPassword(_passwordController.text);
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (context) => const RegisterPhone()));
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

  SizedBox InputTextField({required String labelText, required bool isRePasssword}) {
    return SizedBox(
      width: Sizes.size380,
      child: TextField(
        obscureText: true,
        controller: isRePasssword ? _passwordController2 : _passwordController,
        onChanged: (value) {
          _validatePassword(_passwordController.text, _passwordController2.text);
        },
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.baseColor)),
          labelStyle: const TextStyle(color: Colors.black54),
          labelText: labelText,
        ),
      ),
    );
  }
}
