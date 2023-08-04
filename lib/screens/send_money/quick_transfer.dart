import 'package:banking_app/screens/send_money/confirm_screen.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class QuickTransfer extends StatefulWidget {
  const QuickTransfer({super.key});

  @override
  State<QuickTransfer> createState() => _QuickTransferState();
}

class _QuickTransferState extends State<QuickTransfer> {
  List<Map<String, dynamic>>? _quickTransferList;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();

    _getQuickTransferList();
  }

  Future<void> _getQuickTransferList() async {
    final quickTransferList = await AuthService().getQuickTransferList();

    setState(() {
      _quickTransferList = quickTransferList;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(
              color: AppColors.baseColor,
            ))
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
              child: GridView.builder(
                padding: EdgeInsets.only(top: Sizes.size24),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 17, mainAxisSpacing: 16, childAspectRatio: 163 / 214),
                itemCount: _quickTransferList?.length ?? 0,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ConfirmTransaction(
                        accountNo: _quickTransferList?[index]['account_no'],
                      ),
                    )),
                    child: Card(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Image.asset(
                                "assets/send_money/quick_transfer.png",
                                fit: BoxFit.cover,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: Sizes.size16, right: Sizes.size16),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Image.asset(
                                        ImagePaths.cardLogo,
                                        width: Sizes.size50,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: Sizes.size60, left: Sizes.size8),
                                      child: Icon(
                                        Icons.person,
                                        size: Sizes.size50,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: Sizes.size12, left: Sizes.size12),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                _quickTransferList?[index]['username'],
                                style: TextStyle(color: AppColors.baseColor, fontSize: Sizes.size16),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: Sizes.size8, left: Sizes.size12),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                // '\$ 1,000.00',
                                "${_quickTransferList?[index]['account_no']}",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
