import 'package:banking_app/services/auth_service.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:banking_app/widgets/app_button.dart';
import 'package:banking_app/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

import '../main_page_controller.dart';

class CardDetail extends StatefulWidget {
  final Map<String, dynamic> card;
  const CardDetail({super.key, required this.card});

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  num totalBalance = 0;

  String amount = '';
  String _pocketName = '';
  String _target = '';

  final _transferController = TextEditingController();
  final _pocketNameController = TextEditingController();
  final _targetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTotalBalance();
  }

  Future<void> getTotalBalance() async {
    Map<String, dynamic>? userData = await AuthService().getCurrentUserData();

    setState(() {
      totalBalance = userData!['total_balance'];
    });
  }

  void assignValues() {
    setState(() {
      amount = _transferController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map card = widget.card;

    return Scaffold(
      appBar: BaseAppBar(title: card['balance_type'], canPop: true),
      body: Padding(
        padding: EdgeInsets.only(right: Sizes.size16, left: Sizes.size16, top: Sizes.size24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Balance'),
            Padding(
              padding: EdgeInsets.only(top: Sizes.size8, bottom: Sizes.size16),
              child: Text(
                '\$ ${card['balance'].toString()}',
                style: TextStyle(color: AppColors.baseColor, fontSize: Sizes.size20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Sizes.size8),
              child: LinearProgressIndicator(
                value: card['balance'] / card['target'],
                color: AppColors.baseColor,
                backgroundColor: Colors.black12,
                minHeight: Sizes.size8,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '\$ 0',
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  '\$ ${card['target'].toString()}',
                  style: const TextStyle(color: Colors.black54),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Sizes.size32),
              child: Container(
                padding: EdgeInsets.only(bottom: Sizes.size12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Sizes.size12),
                    border: Border.all(
                      color: Colors.black12,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    deposit(context, card),
                    withdraw(context, card),
                    editCard(context, card),
                  ],
                ),
              ),
            ),
            Text(
              'Transaction',
              style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Column deposit(BuildContext context, Map<dynamic, dynamic> card) {
    return Column(
      children: [
        GestureDetector(
            onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: Sizes.size24),
                              child: Text(
                                'Deposit',
                                style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
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
                                            '\$ $totalBalance',
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
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: Sizes.size24),
                              child: TextField(
                                controller: _transferController,
                                onChanged: (value) => assignValues(),
                                style: TextStyle(fontSize: Sizes.size24, fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                    prefix: const Text('\$ '),
                                    suffix: Text(Strings.usd),
                                    border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                    focusedBorder: const UnderlineInputBorder()),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(bottom: Sizes.size40),
                              child: SizedBox(
                                width: double.infinity,
                                height: Sizes.size53,
                                child: AppButton(
                                  title: 'Deposit',
                                  isValid: true,
                                  onTap: () async {
                                    await AuthService().updateCardDeposit(amount, card['card_no']);
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => const MainPageController(
                                              index: 1,
                                            )));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            child: Image.asset(
              ImagePaths.deposit,
              width: Sizes.size24,
              height: Sizes.size50,
            )),
        const Text('Deposit'),
      ],
    );
  }

  Column withdraw(BuildContext context, Map<dynamic, dynamic> card) {
    return Column(
      children: [
        GestureDetector(
            onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: Sizes.size24),
                              child: Text(
                                'Withdraw',
                                style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
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
                                            '\$ $totalBalance',
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
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: Sizes.size24),
                              child: TextField(
                                controller: _transferController,
                                onChanged: (value) => assignValues(),
                                style: TextStyle(fontSize: Sizes.size24, fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                    prefix: Text('\$ $amount '),
                                    suffix: Text(Strings.usd),
                                    border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                    focusedBorder: const UnderlineInputBorder()),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(bottom: Sizes.size40),
                              child: SizedBox(
                                width: double.infinity,
                                height: Sizes.size53,
                                child: AppButton(
                                  title: 'Withdraw',
                                  isValid: true,
                                  onTap: () async {
                                    await AuthService().updateCardWithdraw(amount, card['card_no']);
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => const MainPageController(
                                              index: 1,
                                            )));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            child: Image.asset(
              ImagePaths.withdraw,
              width: Sizes.size24,
              height: Sizes.size50,
            )),
        const Text('Withdraw'),
      ],
    );
  }

  Column editCard(BuildContext context, Map<dynamic, dynamic> card) {
    return Column(
      children: [
        GestureDetector(
            onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 400,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: Sizes.size24),
                                child: Text(
                                  'Edit Pocket',
                                  style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: Sizes.size16),
                                child: TextField(
                                  controller: _pocketNameController,
                                  onChanged: (value) {
                                    setState(() {
                                      _pocketName = _pocketNameController.text;
                                    });
                                  },
                                  textAlign: TextAlign.start,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Name pocket',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _targetController,
                                  onChanged: (value) {
                                    setState(() {
                                      _target = _targetController.text;
                                    });
                                  },
                                  textAlign: TextAlign.start,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Target',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: Sizes.size40),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: Sizes.size53,
                                  child: AppButton(
                                    title: 'Save',
                                    isValid: true,
                                    onTap: () async {
                                      await AuthService().editCard(_pocketName, _target, card['card_no']);
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => const MainPageController(
                                                index: 1,
                                              )));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
            child: Image.asset(
              ImagePaths.edit,
              width: Sizes.size24,
              height: Sizes.size50,
            )),
        const Text('Edit'),
      ],
    );
  }
}
