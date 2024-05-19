import 'package:check_table/data/loaders/train_list_loader.dart';
import 'package:check_table/data/loaders/train_loader.dart';
import 'package:check_table/data/savers/train_list_saver.dart';
import 'package:check_table/data/savers/train_saver.dart';
import 'package:check_table/models/train.dart';
import 'package:flutter/foundation.dart';

class TrainRepository extends ChangeNotifier {
  TrainRepository(
      {required TrainListLoader trainListLoader,
      required TrainLoader trainLoader,
      required ListSaver<Train> trainListSaver,
      required TrainSaver trainSaver})
      : _trainListLoader = trainListLoader,
        _trainIdLoader = trainLoader,
        _trainListSaver = trainListSaver,
        _trainSaver = trainSaver;
  final TrainListLoader _trainListLoader;
  final TrainLoader _trainIdLoader;
  final ListSaver<Train> _trainListSaver;
  final TrainSaver _trainSaver;
  List<Train> trains = [];
  Train? get currentTrain => _currentTrain;
  Train? _currentTrain;

  Future<List<Train>> loadTrainList() async {
    trains = await _trainListLoader.load();
    return trains;
  }

  loadTrain() async {
    final id = await _trainIdLoader.load();

    for (final train in trains) {
      if (train.id == id) {
        _currentTrain = train;
        setTrainAndNotify(train);
        break;
      }
    }
  }

  Future<void> addTrain(Train train) async {
    trains.add(train);
    await _trainListSaver.save(trains);
    notifyListeners();
  }

  setTrainAndNotify(Train newValue) {
    _currentTrain = newValue;
    _trainSaver.save(newValue.id);
    notifyListeners();
  }

  clearTrainList() {
    _trainListSaver.save([]);
    notifyListeners();
  }
}
