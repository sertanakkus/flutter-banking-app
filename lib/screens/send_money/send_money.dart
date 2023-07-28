import 'package:banking_app/screens/send_money/company_bank_transaction.dart';
import 'package:banking_app/screens/send_money/other_bank_transaction.dart';
import 'package:banking_app/screens/send_money/quick_transfer.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:flutter/material.dart';

class SendMoney extends StatefulWidget {
  const SendMoney({super.key});

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  final List<Widget> _widgetList = <Widget>[const NewTransfer(), const QuickTransfer()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(Strings.sendFund),
        bottom: TabBar(
          unselectedLabelColor: Colors.black,
          labelColor: AppColors.baseColor,
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              child: Text(Strings.newTransfer),
            ),
            Tab(
              child: Text(Strings.quickTransfer),
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: _widgetList),
    );
  }
}

class NewTransfer extends StatelessWidget {
  const NewTransfer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
      child: Column(
        children: [
          const DFlyUsersArea(),
          const OtherBankUsersArea(),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              Strings.recent,
              style: TextStyle(fontSize: Sizes.size16),
            ),
          ),
          const EmptyTransaction()
        ],
      ),
    );
  }
}

class EmptyTransaction extends StatelessWidget {
  const EmptyTransaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Sizes.size45),
      child: Column(
        children: [
          Image.asset(
            ImagePaths.emptyTransaction,
            width: Sizes.size140,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Sizes.size16),
            child: Text(Strings.emptyTransaction),
          ),
          Text(
            Strings.noTransaction,
            style: const TextStyle(color: Colors.black54),
          )
        ],
      ),
    );
  }
}

class OtherBankUsersArea extends StatelessWidget {
  const OtherBankUsersArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Sizes.size16, bottom: Sizes.size32),
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const OtherBankMoneyTransfer(),
        )),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size12),
              border: Border.all(
                color: Colors.black12,
              )),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size20, vertical: Sizes.size16),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  Icon(
                    Icons.groups_2_outlined,
                    color: AppColors.baseColor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Sizes.size8),
                    child: Text(Strings.oBankUsers),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: Sizes.size20,
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class DFlyUsersArea extends StatelessWidget {
  const DFlyUsersArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Sizes.size32),
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CompanyBankMoneyTransfer(),
        )),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size12),
              border: Border.all(
                color: Colors.black12,
              )),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size20, vertical: Sizes.size16),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  Icon(
                    Icons.people,
                    color: AppColors.baseColor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Sizes.size8),
                    child: Text(Strings.dFlyBankUsers),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: Sizes.size20,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
