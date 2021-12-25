import 'package:flutter/material.dart';
import 'package:mini_finance_mobile/piggy_banks/screens/piggy_bank_list.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(App());
}
class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData().copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.blue[500],
            )),
        home: PiggyBankList());
  }
}

