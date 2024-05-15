import 'package:check_table/data/loaders/station_loader.dart';
import 'package:check_table/data/repos/train_repo.dart';
import 'package:check_table/models/train.dart';
import 'package:check_table/presentation/views/train_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/loaders/train_list_loader.dart';
import 'data/loaders/train_loader.dart';
import 'presentation/views/car_page/car_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final stationLoader = LocalTrainStationLoader();
  await stationLoader.load();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(
                selectedIcon: Icon(Icons.train),
                icon: Icon(Icons.train_outlined),
                label: '火車'),
            NavigationDestination(
                icon: Icon(Icons.list_alt_outlined), label: '清單')
          ],
        ),
        body: ChangeNotifierProvider(
          create: (context) => TrainRepository(
              loader:
                  LocalTrainLoader(stationLoader: LocalTrainStationLoader())),
          child: IndexedStack(index: currentPageIndex, children: pages),
        ),
      ),
    );
  }

  List<Widget> pages = [
    const CarPage(),
    TrainListPage(trainListLoader: LocalTrainListLoader(TrainJsonFactory()))
  ];
}
