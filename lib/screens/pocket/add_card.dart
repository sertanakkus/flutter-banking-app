import 'package:banking_app/utils/constants.dart';
import 'package:banking_app/widgets/app_button.dart';
import 'package:banking_app/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../main_page_controller.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  String _selectedBackground = '1';
  final _pocketNameController = TextEditingController();
  final _targetController = TextEditingController();
  String _target = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: 'New Pocket',
        canPop: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(right: Sizes.size16, left: Sizes.size16, top: Sizes.size24),
        child: Center(
            child: Column(
          children: [
            SizedBox(
              width: 130,
              height: 170,
              child: Card(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.asset(
                          'assets/home_images/card_items/card_frame_$_selectedBackground.png',
                          height: 112,
                          fit: BoxFit.cover,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: Sizes.size12, right: Sizes.size12),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Image.asset(
                                  ImagePaths.cardLogo,
                                  width: Sizes.size45,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: Sizes.size30, left: Sizes.size12),
                              child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Biancalize',
                                    style: TextStyle(color: Colors.white, fontSize: 10),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Sizes.size12),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '1234 5678 9000 0000',
                                  style: TextStyle(color: Colors.white, fontSize: Sizes.size8),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: Sizes.size14, left: Sizes.size12),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Image.asset(
                                  ImagePaths.chip,
                                  width: Sizes.size20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: Sizes.size14, left: Sizes.size10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'balance type',
                                  style: TextStyle(fontSize: Sizes.size10),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: Sizes.size8, left: Sizes.size10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  // '\$ 1,000.00',
                                  '\$  $_target',
                                  style: TextStyle(color: AppColors.baseColor, fontSize: Sizes.size14),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Sizes.size32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedBackground = '1';
                      });
                    },
                    child: Container(
                      decoration: _selectedBackground == '1'
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 3, color: AppColors.baseColor))
                          : null,
                      child: Image.asset(
                        'assets/home_images/card_items/card_frame_1_mini.png',
                        width: 60,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedBackground = '2';
                      });
                    },
                    child: Container(
                      decoration: _selectedBackground == '2'
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 3, color: AppColors.baseColor))
                          : null,
                      child: Image.asset(
                        'assets/home_images/card_items/card_frame_2_mini.png',
                        width: 60,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedBackground = '3';
                      });
                    },
                    child: Container(
                      decoration: _selectedBackground == '3'
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 3, color: AppColors.baseColor))
                          : null,
                      child: Image.asset(
                        'assets/home_images/card_items/card_frame_3_mini.png',
                        width: 60,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedBackground = '4';
                      });
                    },
                    child: Container(
                      decoration: _selectedBackground == '4'
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 3, color: AppColors.baseColor))
                          : null,
                      child: Image.asset(
                        'assets/home_images/card_items/card_frame_4_mini.png',
                        width: 60,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Sizes.size24),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Your Dreams',
                    style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w500),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _pocketNameController,
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name pocket',
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Sizes.size16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.zero,
                child: AppButton(
                  title: 'Create Pocket',
                  isValid: true,
                  onTap: () async {
                    await AuthService()
                        .addCard(_selectedBackground, _target, _pocketNameController.text, '0000 0000 0000 0000');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MainPageController(
                              index: 1,
                            )));
                  },
                ))
          ],
        )),
      ),
    );
  }
}
