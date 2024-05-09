import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

import '../models/car_map.dart';
import '../models/station.dart';

abstract class StationLoader {
  Future<Map<String, Station>> load();
}

class TrainStationLoader implements StationLoader {
  static Map<String, Station>? _cache;

  @override
  Future<Map<String, Station>> load() async {
    if (_cache != null) {
      return _cache!;
    }
    _cache = {};
    String data = await rootBundle.loadString('res/station_data.json');
    var jsonData = jsonDecode(data);
    final stations = jsonData['data'] as List<dynamic>;
    for (var data in stations) {
      final st = data as List<dynamic>;
      if (st.length == 3) {
        final no = st[0] as String;
        _cache![no] = TrainStation(name: st[1], no: st[0], english: st[2]);
      } else {
        print('data length error');
      }
    }

    return _cache!;
  }
}

abstract class TrainLoader {
  Future<Train> load();
}

class LocalTrainLoader implements TrainLoader {
  LocalTrainLoader({required this.stationLoader});

  StationLoader stationLoader;

  @override
  Future<Train> load() async {
    //TODO: 假資料
    await Future.delayed(const Duration(seconds: 2));
    final table = ReservedCar.empty(
        seatStartNo: 1, seatEndNo: 52, carNo: '777', shouldReverse: false);
    final stations = await stationLoader.load();
    final stationList =
        getRandomEntries(stations, 5).values.map((e) => e).toList();
    return Train(
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
