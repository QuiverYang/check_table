import 'package:check_table/data/json_interface.dart';
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
      required super.title});

  @override
  String get type => 'TrainImp';

  factory TrainImp.fromJson(Map<String, dynamic> json) {
    return TrainImp(
        tables: json['tables'] ?? [],
        stopStations:
            json['stopStations']?.map((s) => StationFactory().fromJson(s)) ??
                [],
        no: json['no'] ?? '',
        title: json['title'] ?? '');
  }
}
