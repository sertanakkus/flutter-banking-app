import 'package:banking_app/screens/history/information_history.dart';
import 'package:banking_app/screens/request_money.dart';
import 'package:banking_app/screens/send_money/send_money.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:banking_app/widgets/home_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'pocket/add_card.dart';
import 'pocket/card_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _currentUser;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser!;

    setState(() {
      _currentUser = user;
    });

    await _loadUserData(user.uid);
  }

  Future<void> _loadUserData(String uid) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (snapshot.exists) {
      setState(() {
        _userData = snapshot.data() as Map<String, dynamic>?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final String userId = ModalRoute.of(context)!.settings.arguments.toString();

    // print(_userData);

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
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Strings.yourBalance,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _userData != null
                      ? Text(
                          // '\$ 49,250.00',
                          '\$ ${_userData?['total_balance'].toString()}',
                          style: TextStyle(fontSize: Sizes.size24),
                        )
                      : CircularProgressIndicator(
                          color: AppColors.baseColor,
                        ),
                ),
                const Operations(),
                const OfferCard(),
                Padding(
                  padding: EdgeInsets.only(top: Sizes.size32, bottom: Sizes.size20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Row(
                      children: [
                        Image.asset(
                          ImagePaths.wallet2,
                          width: Sizes.size20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: Sizes.size8),
                          child: Text(Strings.myPocket),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddCard(),
                      )),
                      child: Text(
                        Strings.create,
                        style: TextStyle(color: AppColors.baseColor),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            _userData == null
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.baseColor,
                    ),
                  )
                : Cards(
                    cardData: _userData?["cards"],
                  ),
            Padding(
              padding: EdgeInsets.only(top: Sizes.size32, bottom: Sizes.size20),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: Sizes.size8),
                    child: Image.asset(
                      ImagePaths.coin,
                      width: Sizes.size20,
                    ),
                  ),
                  Text(
                    Strings.currency,
                    style: TextStyle(fontSize: Sizes.size16),
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

class OfferCard extends StatelessWidget {
  const OfferCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Image.asset(
            ImagePaths.offer,
            height: Sizes.size150,
          ),
          Padding(
            padding: EdgeInsets.only(right: Sizes.size10, left: Sizes.size24, top: Sizes.size10, bottom: Sizes.size10),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.close,
                  ),
                ),
                Align(alignment: Alignment.topLeft, child: Text(Strings.letsConnect)),
                Padding(
                  padding: EdgeInsets.only(top: Sizes.size16, right: Sizes.size16),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      Strings.offerDescription,
                      style: const TextStyle(color: Colors.black45),
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
    );
  }
}

class Operations extends StatelessWidget {
  const Operations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SendMoney(),
                        )),
                    child: Image.asset(
                      ImagePaths.money_send,
                      width: Sizes.size24,
                      height: Sizes.size50,
                    )),
                Text(Strings.send),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RequestMoney(),
                        )),
                    child: Image.asset(
                      ImagePaths.money_receive,
                      width: Sizes.size24,
                      height: Sizes.size50,
                    )),
                Text(Strings.request),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HistoryInformation(),
                        )),
                    child: Image.asset(
                      ImagePaths.receipt,
                      width: Sizes.size24,
                      height: Sizes.size50,
                    )),
                Text(Strings.history),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  final List? cardData;
  const Cards({super.key, required this.cardData});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 17, mainAxisSpacing: 16, childAspectRatio: 163 / 214),
      itemCount: cardData?.length,
      itemBuilder: (context, index) {
        print(cardData![index]);
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CardDetail(card: cardData![index]),
          )),
          child: Card(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.asset(
                      "assets/home_images/card_items/card_frame_${cardData![index]['background']}.png",
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
                        Padding(
                          padding: EdgeInsets.only(top: Sizes.size53, left: Sizes.size12),
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Biancalize',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: Sizes.size12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              // '1234 5678 9000 0000',
                              cardData?[index]['card_no'],
                              style: TextStyle(color: Colors.white, fontSize: Sizes.size10),
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
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: Sizes.size8, left: Sizes.size12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(cardData?[index]['balance_type']),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Sizes.size8, left: Sizes.size12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      // '\$ 1,000.00',
                      "\$ ${cardData?[index]['target'].toString()}",
                      style: TextStyle(color: AppColors.baseColor, fontSize: Sizes.size16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
