import 'dart:math';

import '../../../models/car_map.dart';
import '../pair_of_seats/pair_of_seat_view_model.dart';

abstract class CarPageViewModel {
  CarPageViewModel(
      {required this.leftSideSeatPairOfSeatViewModels,
      required this.rightSideSeatPairOfSeatViewModels});

  List<PairOfSeatViewModel> leftSideSeatPairOfSeatViewModels;
  List<PairOfSeatViewModel> rightSideSeatPairOfSeatViewModels;

  void resetSeats() {
    for (var vm in leftSideSeatPairOfSeatViewModels) {
      vm.rightSeat.purpose = '';
      vm.leftSeat.purpose = '';
    }
    for (var vm in rightSideSeatPairOfSeatViewModels) {
      vm.rightSeat.purpose = '';
      vm.leftSeat.purpose = '';
    }
  }

  int get rowNo;
}

class CarPageViewModelImp extends CarPageViewModel {
  CarPageViewModelImp(
      {required super.leftSideSeatPairOfSeatViewModels,
      required super.rightSideSeatPairOfSeatViewModels});

  factory CarPageViewModelImp.fromTrain(Train train) {
    final List<PairOfSeatViewModel> leftSideSeatPairOfSeatViewModels = [];
    final List<PairOfSeatViewModel> rightSideSeatPairOfSeatViewModels = [];
    final carTable = train.table.first;
    final tempSeat = NormalSeat(no: -1, purpose: '');
    final destinations = train.stopStations.map((e) => e.name).toList();
    destinations.add('');
    PairOfSeatViewModelImp left = PairOfSeatViewModelImp(
        rightSeat: tempSeat, leftSeat: tempSeat, destinations: destinations);
    PairOfSeatViewModelImp right = PairOfSeatViewModelImp(
        rightSeat: tempSeat, leftSeat: tempSeat, destinations: destinations);
    int leftCounter = 0;
    int rightCounter = 0;
    for (int i = 0; i < carTable.seats.length; i++) {
      if (leftCounter % 2 == 0) {
        left = PairOfSeatViewModelImp(
            rightSeat: tempSeat,
            leftSeat: tempSeat,
            destinations: destinations);
      }
      if (rightCounter % 2 == 0) {
        right = PairOfSeatViewModelImp(
            rightSeat: tempSeat,
            leftSeat: tempSeat,
            destinations: destinations);
      }

      if (i % 4 == 0) {
        left.leftSeat = NormalSeat(no: i + 1, purpose: '');
        leftCounter += 1;
      } else if (i % 4 == 1) {
        right.rightSeat = NormalSeat(no: i + 1, purpose: '');
        rightCounter += 1;
      } else if (i % 4 == 2) {
        left.rightSeat = NormalSeat(no: i + 1, purpose: '');
        leftCounter += 1;
        leftSideSeatPairOfSeatViewModels.add(left);
      } else if (i % 4 == 3) {
        right.leftSeat = NormalSeat(no: i + 1, purpose: '');
        rightCounter += 1;
        rightSideSeatPairOfSeatViewModels.add(right);
      }
    }
    return CarPageViewModelImp(
        leftSideSeatPairOfSeatViewModels: leftSideSeatPairOfSeatViewModels,
        rightSideSeatPairOfSeatViewModels: rightSideSeatPairOfSeatViewModels);
  }

  @override
  int get rowNo => max(leftSideSeatPairOfSeatViewModels.length,
      rightSideSeatPairOfSeatViewModels.length);
}
