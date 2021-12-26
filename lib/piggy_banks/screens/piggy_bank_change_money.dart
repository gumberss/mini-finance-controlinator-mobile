import 'package:flutter/material.dart';
import 'package:mini_finance_mobile/piggy_banks/models/piggy_bank.dart';

class PiggyBankChangeGoalForm extends StatefulWidget {
  final PiggyBank? piggyBank;

  const PiggyBankChangeGoalForm({this.piggyBank});

  @override
  State<StatefulWidget> createState() => PiggyBankMoneyFormState();
}

class PiggyBankMoneyFormState extends State<PiggyBankChangeGoalForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Change Goal"),
        ),

        );
      Scaffold(
        appBar: AppBar(
          title: const Text("Change Goal"),
        ),
        body: Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                "Months to goal: ",
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextField(),
            Text("Months to goal: "),
          ],
        ));
  }
}
