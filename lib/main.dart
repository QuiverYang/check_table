import 'package:check_table/data/loaders/station_loader.dart';
import 'package:check_table/data/repos/train_repo.dart';
import 'package:check_table/data/savers/train_list_saver.dart';
import 'package:check_table/data/savers/train_saver.dart';
import 'package:check_table/models/train.dart';
import 'package:check_table/presentation/views/add_train_page.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TrainRepository(
          trainListLoader: LocalTrainListLoader(TrainJsonFactory()),
          trainLoader: LocalTrainLoader(),
          trainListSaver: LocalTrainListSaver(),
          trainSaver: LocalTrainSaver()),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const MainPage(),
          '/AddTrainPage': (context) => AddTrainPage(),
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: IndexedStack(index: currentPageIndex, children: pages),
    );
  }

  List<Widget> pages = [
    const CarPage(),
    TrainListPage(trainListLoader: LocalTrainListLoader(TrainJsonFactory()))
  ];
}
