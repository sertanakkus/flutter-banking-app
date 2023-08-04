import 'package:banking_app/utils/constants.dart';
import 'package:banking_app/widgets/app_button.dart';
import 'package:banking_app/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class ConfirmTransaction extends StatefulWidget {
  final String accountNo;
  final String? bankName;
  const ConfirmTransaction({super.key, required this.accountNo, this.bankName});

  @override
  State<ConfirmTransaction> createState() => _ConfirmTransactionState();
}

class _ConfirmTransactionState extends State<ConfirmTransaction> {
  Map<String, dynamic>? _userData;
  Map<String, dynamic>? _currentUserData;

  String amount = '';
  final _transferController = TextEditingController();
  bool _isSufficient = false;

  // checkbox
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _getUserData(widget.accountNo);
  }

  Future<void> _getUserData(accountNo) async {
    Object? snapshot = await AuthService().getUserDataByAccountNo(accountNo);
    final currentUserData = await AuthService().getCurrentUserData();

    setState(() {
      _userData = snapshot as Map<String, dynamic>?;
      _currentUserData = currentUserData;
    });
  }

  void assignValues() {
    setState(() {
      amount = _transferController.text;
      _checkBalance(amount);
    });
  }

  Future<void> _checkBalance(String amount) async {
    bool isSufficient = await AuthService().checkBalance(amount);

    setState(() {
      _isSufficient = isSufficient;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: Strings.confirm, canPop: true),
      body: _userData == null
          ? Center(
              child: CircularProgressIndicator(
              color: AppColors.baseColor,
            ))
          : Padding(
              padding: EdgeInsets.only(right: Sizes.size16, left: Sizes.size16, top: Sizes.size24),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person),
                      SizedBox(width: Sizes.size14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.only(bottom: Sizes.size8),
                              child: Text(
                                _userData!['username'],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              )),
                          widget.bankName != null
                              ? Text(
                                  "${widget.bankName} - ${_userData!['account_no']}",
                                  style: const TextStyle(color: Colors.black54),
                                )
                              : Text(
                                  "Dragonfly Bank - ${_userData!['account_no']}",
                                  style: const TextStyle(color: Colors.black54),
                                ),
                        ],
                      ),
                    ],
                  ),
                  Wallet(currentUserData: _currentUserData),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      Strings.totalTranfer,
                      style: TextStyle(fontSize: Sizes.size16, color: Colors.black87),
                    ),
                  ),
                  SizedBox(
                    height: Sizes.size16,
                  ),
                  TextField(
                    controller: _transferController,
                    onChanged: (value) => assignValues(),
                    style: TextStyle(fontSize: Sizes.size24, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        prefix: const Text('\$ '),
                        suffix: Text(Strings.usd),
                        border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: const UnderlineInputBorder()),
                  ),
                  CheckboxListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(top: Sizes.size20),
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Add to quick transfer'),
                    checkColor: Colors.white,
                    activeColor: Colors.green,
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  const Spacer(),
                  Image.asset(ImagePaths.securePayment),
                  Padding(
                    padding: EdgeInsets.only(bottom: Sizes.size40, top: Sizes.size32),
                    child: AppButton(
                      title: Strings.transferNow,
                      isValid: true,
                      onTap: () {
                        if (_isSufficient == true) {
                          AuthService().updateBalance(
                              senderUserId: _currentUserData!['id'], receiverUserId: _userData!['id'], amount: amount);
                          isChecked.toString() == 'true' ? AuthService().addToQuickTransfer(_userData!['id']) : null;

                          AuthService().updateHistory('out', _userData!['id'], amount);
                          Navigator.of(context).pushNamed('/success-send-money', arguments: amount);
                        } else {
                          showModalBottomSheet(
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
                                            'Insufficient Balance!',
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
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class ReceiverUser extends StatelessWidget {
  const ReceiverUser({
    super.key,
    required Map<String, dynamic>? userData,
    String? bankName,
  }) : _userData = userData;

  final Map<String, dynamic>? _userData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.person),
        SizedBox(width: Sizes.size14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(bottom: Sizes.size8),
                child: Text(
                  _userData!['username'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
            Text(
              " - ${_userData!['account_no']}",
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }
}

class Wallet extends StatelessWidget {
  const Wallet({
    super.key,
    required Map<String, dynamic>? currentUserData,
  }) : _currentUserData = currentUserData;

  final Map<String, dynamic>? _currentUserData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Sizes.size16, bottom: Sizes.size32),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.size12),
            border: Border.all(
              color: AppColors.baseColor,
            )),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size20, vertical: Sizes.size16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.mainWallet,
                      style: TextStyle(fontSize: Sizes.size10, color: Colors.black54),
                    ),
                    SizedBox(
                      height: Sizes.size10,
                    ),
                    Text(
                      '\$ ${_currentUserData!['total_balance']}',
                      style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: AppColors.baseColor,
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
