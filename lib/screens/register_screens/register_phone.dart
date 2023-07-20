import 'package:banking_app/screens/vertification_screen.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:banking_app/widgets/info.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_button.dart';

import '../../utils/country_phone_codes.dart';

class RegisterPhone extends StatefulWidget {
  const RegisterPhone({super.key});

  @override
  State<RegisterPhone> createState() => _RegisterPhoneState();
}

class _RegisterPhoneState extends State<RegisterPhone> {
  final List<Map<String, String>> countryPhoneCodes = CountryPhoneCodes().phoneList;
  final _phoneController = TextEditingController();
  bool _isValid = false;

  late String dropdownValue;
  void _validatePhone(String phone) {
    bool isValid = phone.length >= 5;
    setState(() {
      _isValid = isValid;
    });
  }

  @override
  void initState() {
    super.initState();
    dropdownValue = countryPhoneCodes.first['code']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.register),
        actions: const [Info()],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: 4 / 4,
            color: AppColors.baseColor,
            minHeight: Sizes.size8,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: Sizes.size12, bottom: Sizes.size16),
                        child: Text(
                          Strings.phone,
                          style: TextStyle(fontSize: Sizes.size32),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: Sizes.size12, bottom: Sizes.size32),
                        child: Text(
                          Strings.phoneDesc,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButton<String>(
                        value: dropdownValue,
                        onChanged: (String? value) {
                          setState(() {
                            print(value);
                            dropdownValue = value!;
                          });
                        },
                        items: countryPhoneCodes.map((Map<String, String> country) {
                          return DropdownMenuItem<String>(
                            value: country['code'],
                            child: Text(country['code']!),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        width: Sizes.size255,
                        child: TextField(
                          controller: _phoneController,
                          onChanged: (value) {
                            _validatePhone(_phoneController.text);
                          },
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: Strings.phone,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: Sizes.size55),
                    child: AppButton(
                      title: Strings.next,
                      isValid: _isValid,
                      targetWidget: const VertificationScreen(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}