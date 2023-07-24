import 'package:banking_app/utils/constants.dart';
import 'package:banking_app/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // final String userId = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: const HomeAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Sizes.size16, bottom: Sizes.size8),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your Balance',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '\$ 49,250.00',
                    style: TextStyle(fontSize: Sizes.size24),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Sizes.size20),
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
                        Column(
                          children: [
                            GestureDetector(
                                child: Image.asset(
                              ImagePaths.money_send,
                              width: Sizes.size24,
                              height: 50,
                            )),
                            const Text('Send'),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                                child: Image.asset(
                              ImagePaths.money_receive,
                              width: Sizes.size24,
                              height: 50,
                            )),
                            const Text('Request'),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                                child: Image.asset(
                              ImagePaths.receipt,
                              width: Sizes.size24,
                              height: 50,
                            )),
                            const Text('History'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/home_images/offer.png',
                        height: 139,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 24, top: 10, bottom: 10),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.close,
                              ),
                            ),
                            const Align(alignment: Alignment.topLeft, child: Text("Let's Connect")),
                            Padding(
                              padding: EdgeInsets.only(top: Sizes.size16, right: Sizes.size16),
                              child: const Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "Connect account with marketplace for automatic payment and get \$25 bonus",
                                  style: TextStyle(color: Colors.black45),
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(Icons.arrow_right_alt_outlined),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Sizes.size32, bottom: Sizes.size20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/home_images/wallet_2.png',
                          width: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text('My Pocket'),
                        ),
                      ],
                    ),
                    const Text('Create'),
                  ]),
                ),
              ],
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 17, mainAxisSpacing: 16, childAspectRatio: 163 / 214),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Image.asset(
                            'assets/home_images/card_items/card_frame_1.png',
                            fit: BoxFit.cover,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16, right: 16),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    'assets/home_images/card_items/card_logo.png',
                                    width: 50,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 53, left: 12),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Biancalize',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '1234 5678 9000 0000',
                                    style: TextStyle(color: Colors.white, fontSize: 10),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 14, left: 12),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    'assets/home_images/card_items/chip.png',
                                    width: 22,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8, left: 12),
                        child: Align(alignment: Alignment.topLeft, child: Text('Saving Balance')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 12),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '\$ 1,000.00',
                            style: TextStyle(color: AppColors.baseColor, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Image.asset(
                      'assets/home_images/coin.png',
                      width: 20,
                    ),
                  ),
                  const Text(
                    'Currency',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
