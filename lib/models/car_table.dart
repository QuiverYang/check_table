import 'package:check_table/data/json_interface.dart';
import 'package:check_table/models/seat.dart';

class CarTableFactory implements JsonFactory<CarTable> {
  @override
  CarTable fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    switch (type) {
      case 'ReservedCar':
        return ReservedCar.fromJson(json);
      default:
        throw Exception(
            '[CarTableFactory] cannot transport json to CarTable object\n json:$json}');
    }
  }
}

abstract class CarTable implements ToJson {
  CarTable(
      {required this.seatStartNo,
      required this.seatEndNo,
      required this.shouldReverse,
      required this.carNo,
      required this.seats});

  int seatStartNo;
  int seatEndNo;
  bool shouldReverse;
  int carNo;
  late List<Seat> seats;

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'seatStartNo': seatStartNo,
      'seatEndNo': seatEndNo,
      'shouldReverse': shouldReverse,
      'carNo': carNo,
      'seats': seats.map((s) => s.toJson()).toList(),
    };
  }
}

class ReservedCar extends CarTable {
  ReservedCar(
      {super.seatStartNo = 1,
      super.seatEndNo = 52,
      super.shouldReverse = false,
      super.carNo = 1,
      required super.seats});

  factory ReservedCar.empty({
    int seatStartNo = 1,
    int seatEndNo = 52,
    int carNo = 1,
    bool shouldReverse = false,
  }) {
    List<Seat> seats = [];
    for (int i = 0; i <= seatEndNo - seatStartNo; i++) {
      seats.add(NormalSeat(no: i + 1, purpose: ''));
    }
    if (shouldReverse) {
      seats = seats.reversed.toList();
    }
    return ReservedCar(
        seatStartNo: seatStartNo,
        seatEndNo: seatEndNo,
        carNo: carNo,
        seats: seats);
  }

  @override
  String get type => 'ReservedCar';

  factory ReservedCar.fromJson(Map<String, dynamic> json) {
    return ReservedCar(
      seatStartNo: json['seatStartNo'] ?? -1,
      seatEndNo: json['seatEndNo'] ?? -1,
      carNo: json['carNo'] ?? -1,
      seats: json['seats']
              ?.map((s) => SeatFactory().fromJson(s as Map<String, dynamic>))
              .toList()
              .cast<Seat>() ??
          [],
    );
  }
}
