import 'dart:convert';

import 'package:check_table/data/constants.dart';
import 'package:check_table/data/json_interface.dart';
import 'package:check_table/models/train.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TrainListLoader {
  Future<List<Train>> load();
}

class LocalTrainListLoader implements TrainListLoader {
  LocalTrainListLoader(this.factory);

  JsonFactory<Train> factory;

  @override
  Future<List<Train>> load() async {
    final sp = await SharedPreferences.getInstance();
    final list = sp.getStringList(keyOfTrainList);
    if (list == null) return [];
    return list.map((jsonString) {
      final json = jsonDecode(jsonString);
      return factory.fromJson(json);
    }).toList();
  }
}
