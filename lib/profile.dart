import 'package:banking_app/screens/login_screen.dart';
import 'package:banking_app/services/auth_service.dart';
import 'package:banking_app/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

import 'utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();

    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await AuthService().getCurrentUserData();

    setState(() {
      _userData = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BaseAppBar(title: 'Profile', canPop: false),
        body: _userData != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: Sizes.size20),
                      child: Text(_userData!['username']),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: Sizes.size53,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        )),
                        style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(Colors.red),
                            foregroundColor: const MaterialStatePropertyAll(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.size8)))),
                        child: const Text(
                          'Logout',
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: AppColors.baseColor,
                ),
              ));
  }
}
