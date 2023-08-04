import 'package:banking_app/screens/main_page_controller.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:banking_app/widgets/app_button.dart';
import 'package:banking_app/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class SendMoneySuccessScreen extends StatelessWidget {
  const SendMoneySuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final amount = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
        appBar: const BaseAppBar(title: '', canPop: true),
        body: Padding(
          padding: EdgeInsets.only(right: Sizes.size16, left: Sizes.size16, top: Sizes.size200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/send_money/tick-circle.png',
                width: 80,
              ),
              Padding(
                padding: EdgeInsets.only(top: Sizes.size16),
                child: Text(
                  Strings.paymentSuccessful,
                  style: TextStyle(color: AppColors.baseColor, fontSize: Sizes.size16),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Sizes.size32),
                child: Text(
                  '\$$amount',
                  style: TextStyle(fontSize: Sizes.size32, fontWeight: FontWeight.w500),
                ),
              ),
              // Text(
              //   Strings.transactionSuccessful,
              //   style: TextStyle(fontSize: Sizes.size12, color: Colors.black54),
              // ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: Sizes.size40),
                child: AppButton(
                  title: Strings.backHome,
                  isValid: true,
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) => const MainPageController()));
                  },
                ),
              )
            ],
          ),
        ));
  }
}
