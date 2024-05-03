abstract class Station {
  Station({required this.name, required this.no, required this.english});

  String name;
  String no;
  String english;
}

class TrainStation extends Station {
  TrainStation(
      {required super.name, required super.no, required super.english});

  @override
  String toString() {
    return '$name, $no, $english';
  }
}
