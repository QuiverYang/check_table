import 'package:check_table/data/constants.dart';
import 'package:check_table/models/car_map.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TrainListLoader {
  Future<List<Train>> load();
}

class LocalTrainListLoader implements TrainListLoader {
  @override
  Future<List<Train>> load() async {
    final sp = await SharedPreferences.getInstance();
    final list = sp.getStringList(keyOfTrainList);
    return [
      TrainImp(
        table: [],
        stopStations: [],
        no: '777',
        title: '777 次列車',
      )
    ];
  }
}
