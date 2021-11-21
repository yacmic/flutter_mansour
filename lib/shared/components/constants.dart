import 'package:udemy_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cash_helper.dart';

void signOut(
  context,
) {
  CashHelper.removeData(key: 'token').then((value) {
    if (value == true) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); //800 is the size of each chunk
  pattern.allMatches(text).forEach((element) {
    print(element.group(0));
  });
}

String token = '';

//https://newsapi.org/v2/top-headlines/sources?apiKey=API_KEY

//https://newsapi.org/v2/everything?q=teslat&apiKey=8b890e3eeb564e06aa1b99ef44597fce
