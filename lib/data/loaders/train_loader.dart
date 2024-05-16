import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

abstract class TrainLoader {
  Future<String> load();
}

class LocalTrainLoader implements TrainLoader {
  LocalTrainLoader();

  @override
  Future<String> load() async {
    final sp = await SharedPreferences.getInstance();
    final result = sp.getString(keyOfCurrentTrainId);
    return result ?? '';
  }
}
