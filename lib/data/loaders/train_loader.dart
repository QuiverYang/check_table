import 'dart:math';

import 'package:check_table/data/loaders/station_loader.dart';

import '../../models/car_map.dart';

abstract class TrainLoader {
  Future<TrainImp> load();
}

class LocalTrainLoader implements TrainLoader {
  LocalTrainLoader({required this.stationLoader});

  StationLoader stationLoader;

  @override
  Future<TrainImp> load() async {
    //TODO: 假資料
    await Future.delayed(const Duration(seconds: 2));
    final table = ReservedCar.empty(
        seatStartNo: 1, seatEndNo: 52, carNo: '777', shouldReverse: false);
    final stations = await stationLoader.load();
    final stationList =
        getRandomEntries(stations, 5).values.map((e) => e).toList();
    return TrainImp(
      table: [table],
      stopStations: stationList,
      no: '777',
      title: '777 次列車',
    );
  }
}

Map<K, V> getRandomEntries<K, V>(Map<K, V> map, int count) {
  var rand = Random();
  var keys = map.keys.toList();
  var size = min(count, map.length);
  Map<K, V> result = {};

  for (int i = 0; i < size; i++) {
    var index = rand.nextInt(keys.length);
    var key = keys[index];
    result[key] = map[key]!;
    keys.removeAt(index); // 避免重复选择同一个键
  }

  return result;
}
