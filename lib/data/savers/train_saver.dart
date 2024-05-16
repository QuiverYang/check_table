import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

abstract class TrainSaver {
  Future<bool> save(String id);
}

class LocalTrainSaver implements TrainSaver {
  LocalTrainSaver();

  @override
  Future<bool> save(String id) async {
    final sp = await SharedPreferences.getInstance();
    return await sp.setString(keyOfCurrentTrainId, id);
  }
}
