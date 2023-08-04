import 'package:flutter/services.dart';

mixin AppColors {
  static Color baseColor = const Color(0xFF05BE71);
  static Color disabledColor = const Color(0xFF909090);
}

class Sizes {
  static double size8 = 8;
  static double size10 = 10;
  static double size12 = 12;
  static double size14 = 14;
  static double size16 = 16;
  static double size20 = 20;
  static double size24 = 24;
  static double size29 = 29;
  static double size30 = 30;
  static double size32 = 32;
  static double size38 = 38;
  static double size40 = 40;
  static double size45 = 45;
  static double size50 = 50;
  static double size53 = 53;
  static double size55 = 55;
  static double size60 = 60;
  static double size67 = 67;
  static double size70 = 70;
  static double size72 = 72;
  static double size89 = 89;
  static double size92 = 92;
  static double size140 = 140;
  static double size150 = 150;
  static double size200 = 200;
  static double size255 = 255;
  static double size261 = 261;
  static double size380 = 380;
}

class ImagePaths {
  // onboarding screen 1
  static String onboarding1_1 = 'assets/onboarding_images/credit_card_1.png';
  static String onboarding1_2 = 'assets/onboarding_images/credit_card_1_2.png';

  // onboarding screen 2
  static String onboarding2 = 'assets/onboarding_images/onboarding_2.png';

  // onboarding screen 3
  static String onboarding3 = 'assets/onboarding_images/onboarding_3.png';

  // register screen
  static String googleIcon = 'assets/google_icon.png';

  // veritfication screen
  static String message = 'assets/msg.png';

  static String companyIcon = 'assets/company_icon.png';

  // home screen
  static String companyIconColor = 'assets/company_icon_color.png';
  static String scanner = 'assets/scanner_icon.png';

  static String money_send = 'assets/home_images/money_send.png';
  static String money_receive = 'assets/home_images/money_recive.png';
  static String receipt = 'assets/home_images/receipt.png';

  static String offer = 'assets/home_images/offer.png';
  static String wallet2 = 'assets/home_images/wallet_2.png';

  static String cardFrame1 = 'assets/home_images/card_items/card_frame_1.png';
  static String cardLogo = 'assets/home_images/card_items/card_logo.png';
  static String chip = 'assets/home_images/card_items/chip.png';
  static String coin = 'assets/home_images/coin.png';

  // send money
  static String emptyTransaction = 'assets/send_money/empty_transaction.png';
  static String securePayment = 'assets/send_money/secure_payment.png';

  // pocket
  static String deposit = 'assets/pocket_images/deposit.png';
  static String withdraw = 'assets/pocket_images/withdraw.png';
  static String edit = 'assets/pocket_images/edit.png';
}

class Strings {
  // for buttons
  static String getStarted = 'Get Started';
  static String next = 'Next';
  static String finish = 'Finish';

  // onboarding screen 1
  static String onboarding1Title = 'Easy to manage money';
  static String onboarding1Description = 'Transfer and receive your money easily with dragonfly bank';
  static String swipe = 'Swipe for more';

  // onboarding screen 2
  static String onboarding2Title = 'Transfers between accounts';
  static String onboarding2Description = 'Transferring balances is very easy between dragonfly bank accounts';

  // onboarding screen 2
  static String onboarding3Title = 'Choose as needed';

  // onboarding screen 3
  static String onboarding3Description =
      'Choose the savings you want to open, we have lots of services according to what you need';

  // login screen
  static String welcome = 'Welcome';
  static String loginDesc = 'Enjoy all the features that make it easy for you to manage your finances';
  static String emailUsername = 'Email / Username';
  static String rememberMe = 'Remember me';
  static String forgotPassword = 'Forgot Password?';
  static String haveAccount = "Don't have an account? ";
  static String login = 'Login';
  static String loginGmail = 'Login with Gmail';

  // register main screen
  static String register = 'Register';
  static String registerDesc = 'Create an account and enjoy the benefits we provide for you';
  static String other = 'other';
  static String registerGmail = 'Register with Gmail';
  static String registerEmail = 'Register with Email';

  // register email
  static String email = 'Email';
  static String emailDesc = 'Enter your email to register';

  // register password
  static String password = 'Password';
  static String passwordDesc = 'Enter your password to register';
  static String rePassword = 'Re - Password';

  // register username
  static String username = 'Username';
  static String usernameDesc = 'Enter your username to register';

  // register phone
  static String phone = 'Phone';
  static String phoneDesc = 'Enter your phone to register';

  // verify screen
  static String verify = 'Verify';
  static String verifyDesc = "Enter the verification code that we sent to ";

  // home screen
  static String yourBalance = 'Your Balance';

  static String send = 'Send';
  static String request = 'Request';
  static String history = 'History';

  static String letsConnect = "Let's Connect";
  static String offerDescription = "Connect account with marketplace for automatic payment and get \$25 bonus";

  static String myPocket = "My Pocket";
  static String create = "Create";
  static String currency = "Currency";

  // send money
  static String sendFund = 'Send Fund';
  static String newTransfer = 'New Transfer';
  static String quickTransfer = 'Quick Transfer';
  static String dFlyBankUsers = 'Dragonfly bank users';
  static String oBankUsers = 'Other bank users';
  static String recent = 'Recent';
  static String emptyTransaction = 'Empty Transaction';
  static String noTransaction = 'You have no transactions at this time';
  static String account = 'Account';
  static String accountTextField = 'Enter the account number or username';
  static String accountTextFieldLabel = 'Account / Username';
  static String confirm = 'Confirm';
  static String mainWallet = 'Main Wallet';
  static String totalTranfer = 'Total transfer';
  static String usd = 'USD';
  static String transferNow = 'Transfer Now';
  static String paymentSuccessful = 'Payment Successful';
  static String transactionSuccessful = 'Transaction completed successfully';
  static String backHome = 'Back Home';
}
