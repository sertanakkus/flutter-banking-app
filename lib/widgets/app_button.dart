import 'package:banking_app/utils/constants.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final bool _isValid;
  final String title;
  final void Function() onTap;

  const AppButton({
    super.key,
    required this.title,
    required bool isValid,
    required this.onTap,
  }) : _isValid = isValid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Sizes.size53,
      child: ElevatedButton(
        onPressed: onTap,
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
