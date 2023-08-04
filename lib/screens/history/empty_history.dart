import 'package:banking_app/utils/constants.dart';
import 'package:flutter/material.dart';

class EmptyHistory extends StatelessWidget {
  const EmptyHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // appBar: const BaseAppBar(
        //   title: 'History',
        //   canPop: true,
        // ),
        Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/history_images/empty_history.png",
            width: Sizes.size140,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Sizes.size16),
            child: Text(
              'Empty Transaction',
              style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            'You have no transactions at this time',
            style: TextStyle(fontSize: Sizes.size12, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
