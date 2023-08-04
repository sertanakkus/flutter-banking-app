import 'package:banking_app/screens/register_screens/register_password.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:banking_app/widgets/info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../widgets/app_button.dart';

class RegisterUsername extends StatefulWidget {
  const RegisterUsername({super.key});

  @override
  State<RegisterUsername> createState() => _RegisterEmailState();
}

class _RegisterEmailState extends State<RegisterUsername> {
  final _usernameController = TextEditingController();
  bool _isValid = false;
  bool _isUsernameAvailable = false;

  Future<void> _validateUsername(String username) async {
    bool isValid = username.length >= 6;
    _isUsernameAvailable = await AuthService().checkUsername(username);

    setState(() {
      _isValid = isValid;
    });
  }

  bool _checkUsername() {
    return _isUsernameAvailable && _isValid;
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
            value: 2 / 4,
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
                          Strings.username,
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
                          Strings.usernameDesc,
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
                            controller: _usernameController,
                            onChanged: (value) {
                              _validateUsername(_usernameController.text);
                            },
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: Strings.username,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: Sizes.size55),
                    child: AppButton(
                      title: Strings.next,
                      isValid: _checkUsername(),
                      onTap: () {
                        Provider.of<UserModel>(context, listen: false).setUsername(_usernameController.text);
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (context) => const RegisterPassword()));
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
