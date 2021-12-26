class PiggyBank {
  final String id;
  String name;

   double savedValue;
   DateTime startDate;

   double goalValue;
   DateTime goalDate;

  PiggyBank(this.id, this.name, this.savedValue, this.startDate, this.goalValue,
      this.goalDate);

  static PiggyBank fromJson(Map<String, dynamic> map) {
    return PiggyBank(
        map['id'],
        map['name'],
        double.parse(map['savedValue'].toString()),
        DateTime.fromMillisecondsSinceEpoch(map['startDate']),
        double.parse(map['goalValue'].toString()),
        DateTime.fromMillisecondsSinceEpoch(map['goalDate']));
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'savedValue': savedValue,
    'startDate': startDate.millisecondsSinceEpoch,
    'goalValue': goalValue,
    'goalDate': goalDate.millisecondsSinceEpoch,
  };
}
