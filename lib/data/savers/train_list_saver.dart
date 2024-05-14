import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

abstract class TrainListSaver {
  Future<void> save(List<String> jsonStrings);
}

class LocalTrainListSaver implements TrainListSaver {
  @override
  Future<void> save(List<String> jsonStrings) async {
    final sp = await SharedPreferences.getInstance();
    sp.setStringList(keyOfTrainList, jsonStrings);
  }
}
