import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PiggyBankForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PiggyBankFormState();
}

class PiggyBankFormState extends State<PiggyBankForm> {
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
              const Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(labelText: "Name"),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(labelText: "Description"),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "Goal", hintText: "100.000,00"),
                    keyboardType: TextInputType.number,
                  )),
              const Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
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
                    print(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: () {
                        //final String? name = _nameController.text;
                        //final int? accountNumber = int.tryParse(_accountNumberController.text);
                        //if (name != null && accountNumber != null) {
                        //  final contact = Contact(1, name, accountNumber);
                        //  Navigator.pop(context, contact);
                        // }
                      },
                      child: Text('Create')),
                ),
              )
            ],
          ),
        )));
  }
}
