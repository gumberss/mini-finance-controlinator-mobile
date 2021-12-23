import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_finance_mobile/piggy_banks/screens/piggy_bank_form.dart';

class PiggyBankList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Piggy Banks"),
      ),
      body: PiggyBankCardList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PiggyBankForm()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class PiggyBankCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [

          PiggyBankCard(),
          PiggyBankCard(),
          PiggyBankCard(),
          PiggyBankCard(),
          PiggyBankCard(),
          PiggyBankCard(),
          PiggyBankCard(),
          PiggyBankCard(),
          PiggyBankCard(),
        ],
      ),
    );
  }
}

class PiggyBankCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        child: InkWell(
          onTap: () {},
          child: PiggyBankCardContent(),
        ),
      ),
    );
  }
}

class PiggyBankCardContent extends StatelessWidget {
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
                "Cofrinho 1",
                style: TextStyle(fontSize: 24),
              ),
              Icon(Icons.edit)
            ],
          ),
          PiggyBankDateData(),
          PiggyBankMoneyData()
        ],
      ),
    );
  }
}

class PiggyBankDateData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("20/10/2018", style: TextStyle(fontSize: 16)),
          Icon(Icons.arrow_forward_outlined),
          Text("1500 Meses", style: TextStyle(fontSize: 16)),
          Icon(Icons.arrow_forward_outlined),
          Text("20/10/2024", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class PiggyBankMoneyData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("100,00", style: TextStyle(fontSize: 16)),
          Icon(Icons.arrow_forward_outlined),
          Text("600,00/Mês", style: TextStyle(fontSize: 16)),
          Icon(Icons.arrow_forward_outlined),
          Text("15.000,00", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
