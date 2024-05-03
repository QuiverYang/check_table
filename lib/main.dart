import 'package:flutter/material.dart';

import 'data/loader.dart';
import 'presentation/views/car_page/car_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final stationLoader = TrainStationLoader();
  await stationLoader.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CarPage(
        loader: LocalCarPageLoader(),
      ),
    );
  }
}
