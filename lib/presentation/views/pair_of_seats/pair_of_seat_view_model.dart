import 'package:check_table/models/car_map.dart';

abstract class PairOfSeaPairOfSeatViewModel {
  PairOfSeaPairOfSeatViewModel(
      {required this.rightSeat,
      required this.leftSeat,
      required this.destinations});

  Seat rightSeat;
  Seat leftSeat;
  List<String> destinations;
}

class PairOfSeatViewModelImp extends PairOfSeaPairOfSeatViewModel {
  PairOfSeatViewModelImp(
      {required super.rightSeat,
      required super.leftSeat,
      required super.destinations});

  factory PairOfSeatViewModelImp.test() {
    return PairOfSeatViewModelImp(
        rightSeat: NormalSeat(no: 1, purpose: '台南'),
        leftSeat: NonSeat(no: 2),
        destinations: ['台北', '台中', '台南', '高雄', '']);
  }
}
