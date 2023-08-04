import 'package:banking_app/screens/pocket/add_card.dart';
import 'package:banking_app/screens/pocket/card_detail.dart';
import 'package:banking_app/services/auth_service.dart';
import 'package:banking_app/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class PocketMainScreen extends StatefulWidget {
  const PocketMainScreen({super.key});

  @override
  State<PocketMainScreen> createState() => _PocketMainScreenState();
}

class _PocketMainScreenState extends State<PocketMainScreen> {
  List<dynamic> _cards = [];
  bool _isLoading = false;

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> _getUserCards() async {
    _changeLoading();
    Map<String, dynamic>? userData = await AuthService().getCurrentUserData();
    var cards = userData!['cards'];

    setState(() {
      _cards = cards;
    });
    _changeLoading();
  }

  @override
  void initState() {
    _getUserCards();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading == true
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.baseColor,
            ),
          )
        : Scaffold(
            appBar: BaseAppBar(
              title: 'Pocket',
              canPop: false,
              action: IconButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddCard(),
                      )),
                  icon: const Icon(Icons.add)),
            ),
            body: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
                  child: Cards(cardData: _cards),
                ),
              ],
            ),
          );
  }
}

class Cards extends StatelessWidget {
  final List? cardData;
  const Cards({super.key, required this.cardData});

  @override
  Widget build(BuildContext context) {
    print(cardData);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 17, mainAxisSpacing: 16, childAspectRatio: 163 / 214),
      itemCount: cardData!.length,
      itemBuilder: (context, index) {
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
