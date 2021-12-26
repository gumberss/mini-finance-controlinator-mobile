import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:mini_finance_mobile/piggy_banks/models/piggy_bank.dart';
import 'package:mini_finance_mobile/piggy_banks/piggy_banks_services/PiggyBankService.dart';
import 'package:uuid/uuid.dart';

class PiggyBankForm extends StatefulWidget {
  final PiggyBank? piggyBank;

  PiggyBankForm({this.piggyBank});

  @override
  State<StatefulWidget> createState() =>
      PiggyBankFormState(piggyBank: piggyBank);
}

class PiggyBankFormState extends State<PiggyBankForm> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _goalValueCtrl = TextEditingController();
  final TextEditingController _goalDateCtrl = TextEditingController();
  final TextEditingController alreadySavedCtrl = TextEditingController();

  final PiggyBank? piggyBank;

  PiggyBankFormState({this.piggyBank}) {
    goalDateMilliseconds = piggyBank?.goalDate.millisecondsSinceEpoch;
  }

  int? goalDateMilliseconds;

  @override
  Widget build(BuildContext context) {
    DateTime? goalDate = null;
    if (piggyBank != null) {
      _nameCtrl.text = piggyBank!.name;
      _goalValueCtrl.text = piggyBank!.goalValue.toString();
      _goalDateCtrl.text =
          piggyBank!.goalDate.millisecondsSinceEpoch.toString();
      alreadySavedCtrl.text = piggyBank!.savedValue.toString();
      goalDate = piggyBank!.goalDate;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Piggy Bank Form"),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(labelText: "Name"),
                ),
              ),
              /* const Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(labelText: "Description"),
                ),
              ),*/
              Padding(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: _goalValueCtrl,
                    decoration: InputDecoration(
                        labelText: "Goal", hintText: "100,000.00"),
                    keyboardType: TextInputType.number,
                  )),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  controller: alreadySavedCtrl,
                  decoration: InputDecoration(
                      labelText: "Already Saved", hintText: "50.00"),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: DateTimeFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'Goal Date',
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  //firstDate: DateTime.now().add(const Duration(days: 1)),
                  initialDate: goalDate ?? DateTime.now(),
                  initialValue: goalDate ?? DateTime.now(),
                  validator: (e) => ((e?.millisecondsSinceEpoch ?? 0) <=
                          DateTime.now().millisecondsSinceEpoch)
                      ? 'Select a date after today'
                      : null,
                  onDateSelected: (DateTime value) {
                    setState(() {
                      goalDateMilliseconds = value.millisecondsSinceEpoch;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (piggyBank != null)
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8, left: 8),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.redAccent),
                                  onPressed: () async {
                                    if (await PiggyBankService()
                                        .deletePiggyBank(piggyBank!)) {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text('Remove')),
                            )),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            child: ElevatedButton(
                                onPressed: () async {
                                  final String? name = _nameCtrl.text;

                                  final double? goalValue =
                                      double.tryParse(_goalValueCtrl.text);
                                  final double? savedValue =
                                      double.tryParse(alreadySavedCtrl.text);
                                  final DateTime startDate = DateTime.now();

                                  if (name == null ||
                                      goalValue == null ||
                                      savedValue == null ||
                                      goalDateMilliseconds == null) return;

                                  final DateTime? goalDate =
                                      DateTime.fromMillisecondsSinceEpoch(
                                          goalDateMilliseconds!);

                                  if (piggyBank == null) {
                                    var piggyBank = PiggyBank(
                                        Uuid().v1(),
                                        name,
                                        savedValue,
                                        startDate,
                                        goalValue,
                                        goalDate!);

                                    if (await PiggyBankService()
                                        .postPiggyBank(piggyBank)) {
                                      Navigator.pop(context);
                                    }
                                  } else {
                                    piggyBank!.goalDate = goalDate!;
                                    piggyBank!.goalValue = goalValue;
                                    piggyBank!.savedValue = savedValue;
                                    piggyBank!.name = name;

                                    if (await PiggyBankService()
                                        .putPiggyBank(piggyBank!)) {
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                child: piggyBank != null
                                    ? Text('Edit')
                                    : Text('Create')),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
