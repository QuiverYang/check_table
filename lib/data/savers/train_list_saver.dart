import 'dart:convert';

import 'package:check_table/models/train.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

abstract class ListSaver<T> {
  Future<void> save(List<T> jsons);
}

class LocalTrainListSaver implements ListSaver<Train> {
  LocalTrainListSaver();

  @override
  Future<void> save(List<Train> trains) async {
    final List<Map<String, dynamic>> jsonList =
        trains.map((train) => train.toJson()).toList();
    print(jsonList.length);
    SharedPreferencesSaverHelper()
        .saveListOfJsonToStringList(keyOfTrainList, jsonList);
  }
}

class SharedPreferencesSaverHelper {
  Future<bool> saveListOfJsonToStringList(
      String key, List<Map<String, dynamic>> jsonList) async {
    try {
      final jsonStrings = jsonList.map((json) => jsonEncode(json)).toList();
      final sp = await SharedPreferences.getInstance();
      return sp.setStringList(key, jsonStrings);
    } catch (error) {
      print('save json list error: ');
      print(error);
    }
    return false;
  }
}
