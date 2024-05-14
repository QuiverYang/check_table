import 'package:check_table/data/loaders/train_loader.dart';
import 'package:check_table/models/car_map.dart';
import 'package:flutter/foundation.dart';

class TrainRepository extends ChangeNotifier {
  TrainRepository({required TrainLoader loader}) : _loader = loader;
  final TrainLoader _loader;

  Train? get currentTrain => _currentTrain;
  Train? _currentTrain;

  loadTrain() async {
    setTrainAndNotify(await _loader.load());
  }

  setTrainAndNotify(Train newValue) {
    _currentTrain = newValue;
    notifyListeners();
  }
}
