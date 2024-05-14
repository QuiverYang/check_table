import 'station.dart';
import 'package:uuid/uuid.dart';

abstract class Train {
  Train(
      {required this.table,
      required this.stopStations,
      required this.no,
      required this.title,
      String? id})
      : id = id ?? const Uuid().v4();

  List<CarTable> table;
  List<Station> stopStations;
  String no;
  String title;
  String id;
}

class TrainImp extends Train {
  TrainImp(
      {required super.table,
      required super.stopStations,
      required super.no,
      required super.title});
}

abstract class CarTable {
  CarTable(
      {required this.seatStartNo,
      required this.seatEndNo,
      required this.shouldReverse,
      required this.carNo,
      required this.seats});

  final int seatStartNo;
  final int seatEndNo;
  final bool shouldReverse;
  final String carNo;
  final List<Seat> seats;
}

class ReservedCar extends CarTable {
  ReservedCar(
      {required super.seatStartNo,
      required super.seatEndNo,
      super.shouldReverse = false,
      required super.carNo,
      required super.seats});

  factory ReservedCar.empty({
    required int seatStartNo,
    required int seatEndNo,
    required String carNo,
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
}

abstract class Seat {
  Seat({this.no = -1, this.purpose = ''});

  final int no;
  String purpose;
}

class NormalSeat extends Seat {
  NormalSeat({required super.no, required super.purpose});
}

class NonSeat extends Seat {
  NonSeat({required super.no}) : super(purpose: '吧台');
}
