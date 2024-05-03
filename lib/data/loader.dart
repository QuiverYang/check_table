import 'dart:convert';

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

abstract class CarPageLoader {
  Future<CarTable> load();
}

class LocalCarPageLoader implements CarPageLoader {
  @override
  Future<CarTable> load() async {
    await Future.delayed(const Duration(seconds: 2));
    return ReservedCar(seatStartNo: 1, seatEndNo: 52, carNo: 777);
  }
}
