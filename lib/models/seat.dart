import 'package:check_table/data/json_interface.dart';

class SeatFactory implements JsonFactory<Seat> {
  @override
  Seat fromJson(Map<String, dynamic> json) {
    String type = json['type'];
    switch (type) {
      case 'NormalSeat':
        return NormalSeat.fromJson(json);
      case 'NonSeat':
        return NonSeat.fromJson(json);
      default:
        throw Exception('Unsupported seat type: $type');
    }
  }
}

abstract class Seat implements ToJson {
  Seat({this.no = -1, this.purpose = ''});

  final int no;
  String purpose;

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'no': no,
      'purpose': purpose,
    };
  }
}

class NormalSeat extends Seat {
  NormalSeat({required super.no, required super.purpose});

  @override
  String get type => 'NormalSeat';

  factory NormalSeat.fromJson(Map<String, dynamic> json) {
    return NormalSeat(no: json['no'] ?? -1, purpose: json['purpose'] ?? '');
  }
}

class NonSeat extends Seat {
  NonSeat({required super.no}) : super(purpose: '吧台');

  @override
  String get type => 'NonSeat';

  factory NonSeat.fromJson(Map<String, dynamic> json) {
    return NonSeat(no: json['no'] ?? -1);
  }
}
