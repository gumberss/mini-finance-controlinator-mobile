import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:mini_finance_mobile/piggy_banks/models/piggy_bank.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PiggyBankService {
  Future<List<PiggyBank>> GetAll() async {
    return List.empty();
    try {
      var result = await get(Uri.https(
          dotenv.env['PIGGY_BANK_API_URL'].toString(),
          dotenv.env['PIGGY_BANK_API_PATH'].toString()));
      List<dynamic> data = jsonDecode(result.body);

      return data.map((e) => PiggyBank.fromJson(e)).toList();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return List.empty();
  }

  Future<bool> postPiggyBank(PiggyBank piggyBank) async {
    try {
      await post(
          Uri.https(dotenv.env['PIGGY_BANK_API_URL'].toString(),
              dotenv.env['PIGGY_BANK_API_PATH'].toString()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(piggyBank.toJson()));
      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> putPiggyBank(PiggyBank piggyBank) async {
    try {
      var result = await put(
          Uri.https(dotenv.env['PIGGY_BANK_API_URL'].toString(),
              dotenv.env['PIGGY_BANK_API_PATH'].toString()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(piggyBank.toJson()));
      debugPrint(result.body.toString());
      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> deletePiggyBank(PiggyBank piggyBank) async {
    try {
      var result = await delete(
          Uri.https(dotenv.env['PIGGY_BANK_API_URL'].toString(),
              dotenv.env['PIGGY_BANK_API_PATH'].toString()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'id': piggyBank.id}));
      debugPrint(result.body.toString());
      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
