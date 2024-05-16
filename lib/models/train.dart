import 'dart:math';

import 'package:check_table/data/json_interface.dart';
import 'package:check_table/data/loaders/station_loader.dart';
import 'package:uuid/uuid.dart';

import 'car_table.dart';
import 'station.dart';

class TrainJsonFactory implements JsonFactory<Train> {
  @override
  Train fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    switch (type) {
      case 'TrainImp':
        return TrainImp.fromJson(json);
      default:
        throw Exception('cannot transport json to Train object\n json:$json}');
    }
  }
}

abstract class Train implements ToJson {
  Train(
      {required this.tables,
      required this.stopStations,
      required this.no,
      required this.title,
      String? id})
      : id = id ?? const Uuid().v4();

  List<CarTable> tables;
  List<Station> stopStations;
  String no;
  String title;
  String id;

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'tables': tables.map((t) => t.toJson()).toList(),
      'stopStations': stopStations.map((s) => s.toJson()).toList(),
      'no': no,
      'title': title,
      'id': id,
    };
  }
}

class TrainImp extends Train {
  TrainImp(
      {required super.tables,
      required super.stopStations,
      required super.no,
      required super.title,
      super.id});

  @override
  String get type => 'TrainImp';

  factory TrainImp.fromJson(Map<String, dynamic> json) {
    return TrainImp(
        tables: json['tables']
                .map((t) => CarTableFactory().fromJson(t))
                .toList()
                .cast<CarTable>() ??
            [],
        stopStations: json['stopStations']
                ?.map((s) => StationFactory().fromJson(s))
                .toList()
                .cast<Station>() ??
            [],
        no: json['no'] ?? '',
        title: json['title'] ?? '',
        id: json['id'] ?? '');
  }

  static Future<TrainImp> test() async {
    await Future.delayed(const Duration(seconds: 2));
    final table = ReservedCar.empty(
        seatStartNo: 1, seatEndNo: 52, carNo: '777', shouldReverse: false);
    final stationLoader = LocalTrainStationLoader();
    final stations = await stationLoader.load();
    final stationList =
        getRandomEntries(stations, 5).values.map((e) => e).toList();
    return TrainImp(
      tables: [table],
      stopStations: stationList,
      no: '777',
      title: 'test次列車 ${Random().nextInt(100)}',
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
