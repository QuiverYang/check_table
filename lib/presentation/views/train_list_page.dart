import 'package:check_table/data/loaders/train_list_loader.dart';
import 'package:flutter/material.dart';

class TrainListPage extends StatefulWidget {
  const TrainListPage({required this.trainListLoader, super.key});
  final TrainListLoader trainListLoader;

  @override
  State<TrainListPage> createState() => _TrainListPageState();
}

class _TrainListPageState extends State<TrainListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('清單'),
        actions: [
          TextButton(
              onPressed: () {},
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  //TODO: 新增車次 表單
                  setState(() {});
                },
              ))
        ],
      ),
      body: FutureBuilder(
          future: widget.trainListLoader.load(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final list = snapshot.data!;
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (cxt, index) {
                  return ListTile(
                    title: Text(list[index].title),
                    subtitle: Text('車次:${list[index].no}'),
                    onTap: () {
                      print('tt: $index');
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('資料讀取錯誤'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
