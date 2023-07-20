import 'package:banking_app/utils/constants.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final StatefulWidget targetWidget;
  final bool _isValid;
  final String title;
  final String? registerType;
  final String? registerData;

  const AppButton(
      {super.key,
      required this.title,
      required bool isValid,
      required this.targetWidget,
      this.registerType,
      this.registerData})
      : _isValid = isValid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Sizes.size53,
      child: ElevatedButton(
        onPressed: () =>
            _isValid ? Navigator.of(context).push(MaterialPageRoute(builder: (context) => targetWidget)) : null,
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
