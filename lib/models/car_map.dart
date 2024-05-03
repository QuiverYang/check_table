import 'station.dart';

class Train {
  Train(
      {required this.table,
      required this.stopStations,
      required this.no,
      required this.title});

  List<CarTable> table;
  List<Station> stopStations;
  String no;
  String title;
}

abstract class CarTable {
  CarTable(
      {required this.seatStartNo,
      required this.seatEndNo,
      required this.shouldReverse,
      required this.carNo});

  final int seatStartNo;
  final int seatEndNo;
  final bool shouldReverse;
  final int carNo;
  final List<Seat> seats = [];
}

class ReservedCar extends CarTable {
  ReservedCar(
      {required super.seatStartNo,
      required super.seatEndNo,
      super.shouldReverse = false,
      required super.carNo});
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
