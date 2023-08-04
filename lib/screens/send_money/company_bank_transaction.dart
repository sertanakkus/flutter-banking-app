import 'package:banking_app/screens/send_money/confirm_screen.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:banking_app/widgets/app_button.dart';
import 'package:banking_app/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class CompanyBankMoneyTransfer extends StatefulWidget {
  const CompanyBankMoneyTransfer({super.key});

  @override
  State<CompanyBankMoneyTransfer> createState() => _CompanyBankMoneyTransferState();
}

class _CompanyBankMoneyTransferState extends State<CompanyBankMoneyTransfer> {
  final _accountNoController = TextEditingController();
  bool _isValidAccount = false;

  String accountNo = '';

  void assignValues() {
    setState(() {
      accountNo = _accountNoController.text;
      _checkAccount(accountNo);
    });
  }

  Future<void> _checkAccount(String accountNo) async {
    bool isValidAccount = await AuthService().checkAccount(accountNo);

    setState(() {
      _isValidAccount = isValidAccount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: Strings.sendFund, canPop: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
        child: Padding(
          padding: EdgeInsets.only(top: Sizes.size24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  Strings.account,
                  style: TextStyle(fontSize: Sizes.size32),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Sizes.size16, bottom: Sizes.size32),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    Strings.accountTextField,
                    style: TextStyle(fontSize: Sizes.size12, color: Colors.black54),
                  ),
                ),
              ),
              TextField(
                controller: _accountNoController,
                onChanged: (value) => assignValues(),
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: Strings.accountTextFieldLabel,
                ),
              ),
              const Spacer(),
              Padding(
                  padding: EdgeInsets.only(bottom: Sizes.size40),
                  child: AppButton(
                    title: Strings.next,
                    isValid: true,
                    onTap: () {
                      _isValidAccount
                          ? Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => ConfirmTransaction(accountNo: accountNo)))
                          : showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: Sizes.size255,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.warning,
                                              color: Colors.amber,
                                              size: Sizes.size40,
                                            ),
                                            Text(
                                              'Invalid Account!',
                                              style: TextStyle(fontSize: Sizes.size24),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}


// AlertDialog(
//                             backgroundColor = Colors.white,
//                             title = const Text(
//                               'Invalid Account',
//                               textAlign: TextAlign.center,
//                             ),
//                             actions = [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Text(
//                                   'OK',
//                                   style: TextStyle(color: AppColors.baseColor),
//                                 ),
//                               ),
//                             ],
//                           )