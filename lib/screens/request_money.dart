import 'package:banking_app/utils/constants.dart';
import 'package:banking_app/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class RequestMoney extends StatelessWidget {
  const RequestMoney({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(title: 'Request', canPop: true),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: Sizes.size45),
                child: Image.asset(
                  "assets/request_money/company_icon.png",
                  width: Sizes.size140,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Sizes.size32),
                child: Image.asset(
                  "assets/request_money/qr_code.png",
                  width: Sizes.size255,
                ),
              ),
              Text(
                'Rizky Sentro Mahardy',
                style: TextStyle(fontSize: Sizes.size20),
              ),
              Padding(
                padding: EdgeInsets.only(top: Sizes.size16, bottom: 80),
                child: const Text(
                  '8273 8293 37292',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              const ShareButton(),
              SizedBox(
                height: Sizes.size16,
              ),
              const DownloadButton()
            ],
          ),
        ),
      ),
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Sizes.size53,
      child: ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.transparent),
            elevation: MaterialStatePropertyAll(0),
            foregroundColor: MaterialStatePropertyAll(Colors.black),
            side: MaterialStatePropertyAll(BorderSide(color: Colors.black12))),
        onPressed: () {},
        child: const Text('Share'),
      ),
    );
  }
}

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Sizes.size53,
      child: ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.transparent),
            elevation: MaterialStatePropertyAll(0),
            foregroundColor: MaterialStatePropertyAll(Colors.black),
            side: MaterialStatePropertyAll(BorderSide(color: Colors.black12))),
        onPressed: () {},
        child: const Text('Download'),
      ),
    );
  }
}
