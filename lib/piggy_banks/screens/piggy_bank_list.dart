import 'dart:ffi';

import 'package:jiffy/jiffy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_finance_mobile/piggy_banks/models/piggy_bank.dart';
import 'package:mini_finance_mobile/piggy_banks/piggy_banks_services/PiggyBankService.dart';
import 'package:mini_finance_mobile/piggy_banks/screens/piggy_bank_change_money.dart';
import 'package:mini_finance_mobile/piggy_banks/screens/piggy_bank_form.dart';
import 'package:intl/intl.dart';

class PiggyBankList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PiggyBankListState();
  }
}

class PiggyBankListState extends State<PiggyBankList> {
  void notifyList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Piggy Banks"),
      ),
      body: PiggyBankCardList(notifyList),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: FloatingActionButton(
              heroTag: "Change Piggy Bank Goal",
              backgroundColor: Colors.green,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => PiggyBankChangeGoalForm()))
                    .then((value) => setState(() {}));
              },
              child: Icon(Icons.attach_money),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16),
            child: FloatingActionButton(
              heroTag: "Add New",
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => PiggyBankForm()))
                    .then((value) => setState(() {}));
              },
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}

class PiggyBankCardList extends StatelessWidget {
  final _piggyBankService = PiggyBankService();
  final Function notifyParent;

  PiggyBankCardList(this.notifyParent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            initialData: List<PiggyBank>.empty(growable: true),
            future: _piggyBankService.GetAll(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PiggyBank>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  //nothing was done
                  break;
                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        Text('Loading')
                      ],
                    ),
                  );
                  break;
                case ConnectionState.active:
                  //stream
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    final List<PiggyBank> piggyBanks = snapshot.data!;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final piggyBank = piggyBanks[index];
                        return PiggyBankCard(piggyBank, this.notifyParent);
                      },
                      itemCount: piggyBanks.length,
                    );
                  }
                  break;
              }

              return Text("Treta");
            }));
  }
}

class PiggyBankCard extends StatelessWidget {
  final PiggyBank _piggyBank;
  final Function notifyParent;

  PiggyBankCard(this._piggyBank, this.notifyParent);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => PiggyBankForm(piggyBank: _piggyBank)))
                .then((value) => notifyParent());
          },
          child: PiggyBankCardContent(_piggyBank),
        ),
      ),
    );
  }
}

class PiggyBankCardContent extends StatelessWidget {
  final PiggyBank _piggyBank;

  PiggyBankCardContent(this._piggyBank);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _piggyBank.name,
                style: TextStyle(fontSize: 24),
              )
            ],
          ),
          PiggyBankDateData(_piggyBank),
          PiggyBankMoneyData(_piggyBank)
        ],
      ),
    );
  }
}

class PiggyBankDateData extends StatelessWidget {
  final PiggyBank _piggyBank;

  PiggyBankDateData(this._piggyBank);

  @override
  Widget build(BuildContext context) {
    final dateFormat = new DateFormat('dd-MM-yyyy');

    var monthsToGo = Jiffy(_piggyBank.goalDate)
        .diff(_piggyBank.startDate, Units.MONTH)
        .toString();

    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(dateFormat.format(_piggyBank.startDate),
              style: TextStyle(fontSize: 16)),
          Icon(Icons.arrow_forward_outlined),
          Text("$monthsToGo Months"
              ,
              style: TextStyle(fontSize: 16)),
          Icon(Icons.arrow_forward_outlined),
          Text(dateFormat.format(_piggyBank.goalDate),
              style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class PiggyBankMoneyData extends StatelessWidget {
  final PiggyBank _piggyBank;

  PiggyBankMoneyData(this._piggyBank);

  @override
  Widget build(BuildContext context) {
    var diffDateInMonth =
        Jiffy(_piggyBank.goalDate).diff(_piggyBank.startDate, Units.MONTH);

    final double differenceValue = _piggyBank.goalValue - _piggyBank.savedValue;

    if (diffDateInMonth == 0) diffDateInMonth = 1;

    var differenceByMonth =
        (differenceValue / diffDateInMonth).toStringAsFixed(2);

    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_piggyBank.savedValue.toString(),
              style: TextStyle(fontSize: 16)),
          Icon(Icons.arrow_forward_outlined),
          Text("$differenceByMonth/Month", style: TextStyle(fontSize: 16)),
          Icon(Icons.arrow_forward_outlined),
          Text(_piggyBank.goalValue.toString(), style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
