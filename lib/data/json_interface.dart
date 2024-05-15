abstract class JsonFactory<T extends ClassType> {
  T fromJson(Map<String, dynamic> json);
}

abstract class ToJson implements ClassType {
  Map<String, dynamic> toJson();
}

abstract class ClassType {
  String get type;
}
