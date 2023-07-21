import 'package:banking_app/services/auth_service.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

class AppButton extends StatelessWidget {
  final StatefulWidget? targetWidget;
  final String? pushNamedTarget;
  final bool _isValid;
  final String title;
  final String? registerType;
  final List<String>? registerData;

  const AppButton(
      {super.key,
      required this.title,
      required bool isValid,
      this.targetWidget,
      this.registerType,
      this.registerData,
      this.pushNamedTarget})
      : _isValid = isValid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Sizes.size53,
      child: ElevatedButton(
        onPressed: () {
          if (registerType != null && registerData != null) {
            if (registerType == 'email') {
              Provider.of<UserModel>(context, listen: false).setEmail(registerData![0]);
            } else if (registerType == 'username') {
              Provider.of<UserModel>(context, listen: false).setUsername(registerData![0]);
            } else if (registerType == 'password') {
              Provider.of<UserModel>(context, listen: false).setPassword(registerData![0]);
            } else if (registerType == 'phone') {
              Provider.of<UserModel>(context, listen: false).setPhone(registerData![0]);
              AuthService().signUp(context,
                  username: Provider.of<UserModel>(context, listen: false).username!,
                  email: Provider.of<UserModel>(context, listen: false).email!,
                  password: Provider.of<UserModel>(context, listen: false).password!,
                  phone: Provider.of<UserModel>(context, listen: false).phone!);
            } else if (registerType == 'login') {
              // print(registerData);
              AuthService()
                  .signIn(context, username: registerData![0], email: registerData![0], password: registerData![1]);
            }
          }
          if (targetWidget != null && _isValid) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => targetWidget!));
          } else if (pushNamedTarget != null && _isValid) {
            Navigator.of(context).pushNamed(pushNamedTarget!);
          }
        },
        style: ButtonStyle(
            backgroundColor: _isValid
                ? MaterialStatePropertyAll(AppColors.baseColor)
                : MaterialStatePropertyAll(AppColors.disabledColor),
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.size8)))),
        child: Text(
          title,
        ),
      ),
    );
  }
}
