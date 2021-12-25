import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mini_finance_mobile/piggy_banks/models/piggy_bank.dart';
import 'package:mini_finance_mobile/piggy_banks/piggy_banks_services/PiggyBankService.dart';
import 'package:uuid/uuid.dart';

class PiggyBankForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PiggyBankFormState();
}

class PiggyBankFormState extends State<PiggyBankForm> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _goalValueCtrl = TextEditingController();
  final TextEditingController _goalDateCtrl = TextEditingController();
  final TextEditingController alreadySavedCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        labelText: "Goal", hintText: "100.000,00"),
                    keyboardType: TextInputType.number,
                  )),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  controller: alreadySavedCtrl,
                  decoration: InputDecoration(
                      labelText: "Already Saved", hintText: "50,00"),
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
                  firstDate: DateTime.now(),
                  validator: (e) => ((e?.millisecondsSinceEpoch ?? 0) <=
                          DateTime.now().millisecondsSinceEpoch)
                      ? 'Select a date after today'
                      : null,
                  onDateSelected: (DateTime value) {
                    debugPrint(value.toIso8601String());
                    _goalDateCtrl.text =
                        value.millisecondsSinceEpoch.toString();
                    setState(() {});
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: () async {
                        final String? name = _nameCtrl.text;

                        var goalDateMilliseconds =
                            int.tryParse(_goalDateCtrl.text);

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
                                goalDateMilliseconds);

                        var piggyBank = PiggyBank(Uuid().v1(), name, savedValue,
                            startDate, goalValue, goalDate!);

                        if (await PiggyBankService().postPiggyBank(piggyBank)) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Create')),
                ),
              )
            ],
          ),
        )));
  }
}
