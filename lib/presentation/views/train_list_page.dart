import 'package:check_table/data/loaders/station_loader.dart';
import 'package:check_table/data/loaders/train_list_loader.dart';
import 'package:check_table/data/loaders/train_loader.dart';
import 'package:check_table/models/train.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repos/train_repo.dart';

class TrainListPage extends StatefulWidget {
  const TrainListPage({required this.trainListLoader, super.key});

  final TrainListLoader trainListLoader;

  @override
  State<TrainListPage> createState() => _TrainListPageState();
}

class _TrainListPageState extends State<TrainListPage> {
  List<Train> trains = [];

  @override
  void initState() {
    super.initState();
    widget.trainListLoader.load().then((value) {
      setState(() {
        trains = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final trainRepo = context.watch<TrainRepository>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('清單'),
        actions: [
          TextButton(
              onPressed: () {},
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  //TODO: 新增車次 表單
                  final trainLoader = LocalTrainLoader(
                      stationLoader: LocalTrainStationLoader());
                  final train = await trainLoader.load();
                  setState(() {
                    trains.add(train);
                  });
                },
              ))
        ],
      ),
      body: ListView.builder(
        itemCount: trains.length,
        itemBuilder: (cxt, index) {
          return ListTile(
            title: Text(trains[index].title),
            subtitle: Text('車次:${trains[index].no}'),
            onTap: () {
              print('tt: $index');
              trainRepo.setTrainAndNotify(trains[index]);
            },
          );
        },
      ),
    );
  }
}
