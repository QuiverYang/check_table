import 'package:check_table/data/loaders/train_list_loader.dart';
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
  @override
  void initState() {
    super.initState();
    final repo = Provider.of<TrainRepository>(context, listen: false);
    repo.loadTrainList().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final trainRepo = context.watch<TrainRepository>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('清單'),
        leading: TextButton(
          onPressed: () {
            trainRepo.clearTrainList();
          },
          child: const Text('全部清除'),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  await Navigator.of(context).pushNamed('/AddTrainPage');
                  setState(() {});
                },
              ))
        ],
      ),
      body: FutureBuilder(
          future: trainRepo.loadTrainList(),
          builder: (context, snapshot) {
            final trains = trainRepo.trains;
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: trains.length,
                itemBuilder: (cxt, index) {
                  return ListTile(
                    title: Text(trains[index].title),
                    subtitle: Text('車次:${trains[index].no}'),
                    onTap: () {
                      trainRepo.setTrainAndNotify(trains[index]);
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
