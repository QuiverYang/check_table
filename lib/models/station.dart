import 'package:check_table/data/json_interface.dart';

class StationFactory implements JsonFactory<Station> {
  @override
  Station fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    switch (type) {
      case 'TrainStation':
        return TrainStation.fromJson(json);
      default:
        throw Exception(
            '[StationFactory] cannot json to Station object\n json:$json}');
    }
  }
}

abstract class Station implements ToJson {
  Station({required this.name, required this.no, required this.english});

  String name;
  String no;
  String english;

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'no': no,
      'english': english,
    };
  }
}

class TrainStation extends Station {
  TrainStation(
      {required super.name, required super.no, required super.english});

  @override
  String toString() {
    return '$name, $no, $english';
  }

  factory TrainStation.fromJson(Map<String, dynamic> json) {
    return TrainStation(
        name: json['name'] ?? '',
        no: json['no'] ?? '',
        english: json['english'] ?? '');
  }

  @override
  String get type => 'TrainStation';
}
