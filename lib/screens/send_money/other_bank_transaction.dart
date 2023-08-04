import 'package:banking_app/screens/send_money/confirm_screen.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:banking_app/widgets/app_button.dart';
import 'package:banking_app/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class OtherBankMoneyTransfer extends StatefulWidget {
  const OtherBankMoneyTransfer({super.key});

  @override
  State<OtherBankMoneyTransfer> createState() => _OtherBankMoneyTransferState();
}

class _OtherBankMoneyTransferState extends State<OtherBankMoneyTransfer> {
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

  String selectedOption = 'Bank BCA';
  List<String> dropdownOptions = ['Bank BCA', 'Bank BRI', 'Bank Mandiri', 'Bank Panin', 'Bank BSI', 'Bank BNI'];

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
              Padding(
                padding: EdgeInsets.only(bottom: Sizes.size16),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      isDense: true,
                      value: selectedOption,
                      onChanged: (newValue) {
                        setState(() {
                          selectedOption = newValue!;
                        });
                      },
                      items: dropdownOptions.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                    ),
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                      return _isValidAccount
                          ? ConfirmTransaction(
                              accountNo: accountNo,
                              bankName: selectedOption,
                            )
                          : AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text(
                                'Invalid Account',
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(color: AppColors.baseColor),
                                  ),
                                ),
                              ],
                            );
                    }));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
