import 'dart:math';

import 'package:check_table/models/seat.dart';
import 'package:check_table/models/train.dart';

import '../pair_of_seats/pair_of_seat_view_model.dart';

abstract class CarPageViewModel {
  CarPageViewModel({required this.carTableViewModels});

  List<CarTableViewModel> carTableViewModels;

  void resetSeats() {
    for (var element in carTableViewModels) {
      element.resetSeats();
    }
  }

  int rowNo(int index);
}

abstract class CarTableViewModel {
  CarTableViewModel(
      {required this.leftSideSeatPairOfSeatViewModels,
      required this.rightSideSeatPairOfSeatViewModels,
      required this.carNo});

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

  int carNo;
}

class CarTableViewModelImp extends CarTableViewModel {
  CarTableViewModelImp(
      {required super.leftSideSeatPairOfSeatViewModels,
      required super.rightSideSeatPairOfSeatViewModels,
      required super.carNo});
}

class CarPageViewModelImp extends CarPageViewModel {
  CarPageViewModelImp({required super.carTableViewModels});

  factory CarPageViewModelImp.fromTrain(Train train) {
    final List<CarTableViewModel> models = [];
    for (final carTable in train.tables) {
      final List<PairOfSeatViewModel> leftSideSeatPairOfSeatViewModels = [];
      final List<PairOfSeatViewModel> rightSideSeatPairOfSeatViewModels = [];
      final tempSeat = NormalSeat(no: -1, purpose: '');
      final destinations = train.stopStations.map((e) => e.name).toList();
      destinations.add('');
      PairOfSeatViewModelImp left = PairOfSeatViewModelImp(
          rightSeat: tempSeat, leftSeat: tempSeat, destinations: destinations);
      PairOfSeatViewModelImp right = PairOfSeatViewModelImp(
          rightSeat: tempSeat, leftSeat: tempSeat, destinations: destinations);
      int leftCounter = 0;
      int rightCounter = 0;
      //TODO: 位子不滿4個時要補空格位子
      if (carTable.shouldReverse) {
        for (int i = carTable.seatEndNo; i >= carTable.seatStartNo; i--) {
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

          if ((i - 1) % 4 == 0) {
            right.rightSeat = NormalSeat(no: i, purpose: '');
            rightCounter += 1;
          } else if ((i - 1) % 4 == 1) {
            left.leftSeat = NormalSeat(no: i, purpose: '');
            leftCounter += 1;
          } else if ((i - 1) % 4 == 2) {
            right.leftSeat = NormalSeat(no: i, purpose: '');
            rightCounter += 1;
            rightSideSeatPairOfSeatViewModels.add(right);
          } else if ((i - 1) % 4 == 3) {
            left.rightSeat = NormalSeat(no: i, purpose: '');
            leftCounter += 1;
            leftSideSeatPairOfSeatViewModels.add(left);
          }
        }
      } else {
        for (int i = carTable.seatStartNo; i <= carTable.seatEndNo; i++) {
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

          if ((i - 1) % 4 == 0) {
            left.leftSeat = NormalSeat(no: i, purpose: '');
            leftCounter += 1;
          } else if ((i - 1) % 4 == 1) {
            right.rightSeat = NormalSeat(no: i, purpose: '');
            rightCounter += 1;
          } else if ((i - 1) % 4 == 2) {
            left.rightSeat = NormalSeat(no: i, purpose: '');
            leftCounter += 1;
            leftSideSeatPairOfSeatViewModels.add(left);
          } else if ((i - 1) % 4 == 3) {
            right.leftSeat = NormalSeat(no: i, purpose: '');
            rightCounter += 1;
            rightSideSeatPairOfSeatViewModels.add(right);
          }
        }
      }
      final model = CarTableViewModelImp(
          leftSideSeatPairOfSeatViewModels: leftSideSeatPairOfSeatViewModels,
          rightSideSeatPairOfSeatViewModels: rightSideSeatPairOfSeatViewModels,
          carNo: carTable.carNo);
      models.add(model);
    }

    return CarPageViewModelImp(carTableViewModels: models);
  }

  @override
  int rowNo(int index) => max(
        carTableViewModels[index].rightSideSeatPairOfSeatViewModels.length,
        carTableViewModels[index].leftSideSeatPairOfSeatViewModels.length,
      );
}
