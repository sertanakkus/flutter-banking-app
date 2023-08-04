import 'package:banking_app/screens/history/empty_history.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:banking_app/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HistoryInformation extends StatefulWidget {
  const HistoryInformation({super.key});

  @override
  State<HistoryInformation> createState() => HistoryInformationState();
}

class HistoryInformationState extends State<HistoryInformation> {
  num _totalIncome = 0;
  num _totalSpending = 0;
  num _accumulatedFunds = 0;
  List<dynamic>? _history;
  bool _isLoading = false;

  @override
  void initState() {
    _getIncomeSpendingAndHistory();
    super.initState();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _getIncomeSpendingAndHistory() async {
    _changeLoading();

    final totalIncome = await AuthService().getIncome();
    final totalSpending = await AuthService().getSpending();

    final history = await AuthService().getHistory();

    setState(() {
      _totalIncome = totalIncome;
      _totalSpending = totalSpending;
      _accumulatedFunds = totalIncome - totalSpending;

      _history = history;
    });

    _changeLoading();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) async {
    String startDate = args.value.startDate.toString();
    String endDate = args.value.endDate.toString();
    if (endDate != 'null') {
      List newHistory = await AuthService().getTransactionHistoryByDate(startDate, endDate);

      setState(() {
        _history = newHistory;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
            title: 'Information',
            canPop: true,
            action: IconButton(
                onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => SfDateRangePicker(
                        startRangeSelectionColor: AppColors.baseColor,
                        endRangeSelectionColor: AppColors.baseColor,
                        rangeSelectionColor: AppColors.baseColor,
                        rangeTextStyle: const TextStyle(color: Colors.white),
                        view: DateRangePickerView.month,
                        onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.range,
                        monthViewSettings: const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                      ),
                    ),
                icon: const Icon(Icons.calendar_month_outlined))),
        body: _isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.baseColor,
                ),
              )
            : ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: Sizes.size24, bottom: Sizes.size8),
                            child: const Text(
                              'Accumulated funds',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                          Text(
                            '\$ $_accumulatedFunds',
                            style: TextStyle(fontSize: Sizes.size32, fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: Sizes.size32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    child: Column(
                                  children: [
                                    Icon(
                                      Icons.arrow_circle_up,
                                      color: AppColors.baseColor,
                                      size: Sizes.size30,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: Sizes.size8),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.add),
                                          Text(_totalIncome.toString()),
                                        ],
                                      ),
                                    ),
                                    const Text('Weekly Income'),
                                  ],
                                )),
                                Container(
                                    child: Column(
                                  children: [
                                    Icon(
                                      Icons.arrow_circle_down,
                                      color: Colors.red,
                                      size: Sizes.size30,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: Sizes.size8),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.remove),
                                          Text(_totalSpending.toString()),
                                        ],
                                      ),
                                    ),
                                    const Text('Weekly Spending'),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: Sizes.size24),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Transaction',
                                style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          _history!.isEmpty
                              ? const EmptyHistory()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _history?.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: Sizes.size16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                _history![index]['transaction_type'] == 'in'
                                                    ? ImagePaths.money_receive
                                                    : ImagePaths.money_send,
                                                width: Sizes.size24,
                                                height: Sizes.size50,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: Sizes.size12),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _history![index]['username'],
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w500, color: Colors.black),
                                                    ),
                                                    Text(
                                                      '${_history![index]['transaction_type']} - ${_history![index]['date']}',
                                                      style: TextStyle(color: Colors.black26, fontSize: Sizes.size10),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.add),
                                              Text(
                                                '\$  ${_history![index]['amount'].toString()}',
                                                style: const TextStyle(fontWeight: FontWeight.w500),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
  }

  Future<void> dateModalBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 350,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Sizes.size24),
                  child: Text(
                    'Choose Date',
                    style: TextStyle(fontSize: Sizes.size16),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 160,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                              backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
                              elevation: const MaterialStatePropertyAll(0),
                              foregroundColor: MaterialStatePropertyAll(AppColors.baseColor),
                              side: const MaterialStatePropertyAll(BorderSide(color: Colors.black26))),
                          child: Text(
                            '01',
                            style: TextStyle(color: AppColors.baseColor),
                          )),
                    ),
                    SizedBox(
                      width: 160,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                              backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
                              elevation: const MaterialStatePropertyAll(0),
                              foregroundColor: MaterialStatePropertyAll(AppColors.baseColor),
                              side: const MaterialStatePropertyAll(BorderSide(color: Colors.black26))),
                          child: Text('July', style: TextStyle(color: AppColors.baseColor))),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Sizes.size16),
                  child: const Text('To'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 160,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                              backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
                              elevation: const MaterialStatePropertyAll(0),
                              foregroundColor: MaterialStatePropertyAll(AppColors.baseColor),
                              side: const MaterialStatePropertyAll(BorderSide(color: Colors.black26))),
                          child: Text(
                            '01',
                            style: TextStyle(color: AppColors.baseColor),
                          )),
                    ),
                    SizedBox(
                      width: 160,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                              backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
                              elevation: const MaterialStatePropertyAll(0),
                              foregroundColor: MaterialStatePropertyAll(AppColors.baseColor),
                              side: const MaterialStatePropertyAll(BorderSide(color: Colors.black26))),
                          child: Text('July', style: TextStyle(color: AppColors.baseColor))),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Sizes.size24),
                  child: const Text(
                    'Only display 30 days of transactions',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                // const AppButton(title: 'Show Transaction', isValid: true)
              ],
            ),
          ),
        );
      },
    );
  }
}
