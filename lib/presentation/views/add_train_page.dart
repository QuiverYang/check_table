import 'package:check_table/data/loaders/station_loader.dart';
import 'package:check_table/data/loaders/train_loader.dart';
import 'package:check_table/data/repos/train_repo.dart';
import 'package:check_table/data/savers/train_list_saver.dart';
import 'package:check_table/models/train.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class AddTrainPage extends StatefulWidget {
  const AddTrainPage({super.key});

  @override
  State<AddTrainPage> createState() => _AddTrainPageState();
}

class _AddTrainPageState extends State<AddTrainPage> {
  List<Animal> _selectedAnimals = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('新增車次'),
        leading: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('取消')),
        actions: [
          TextButton(
              onPressed: () async {
                //TODO: 填寫的train
                final repo =
                    Provider.of<TrainRepository>(context, listen: false);
                final train = await TrainImp.test();
                await repo.addTrain(train);
                if (mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('確定')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            TextInputCell(
              title: '1. 列車標題',
              onChanged: (newValue) {},
            ),
            TextInputCell(
              title: '2. 列車號碼',
              onChanged: (newValue) {},
            ),
            MultiSelectDialogField(
              items: _items,
              title: const Text("停靠站"),
              selectedColor: Colors.blue,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              buttonIcon: const Icon(
                Icons.train,
                color: Colors.blue,
              ),
              buttonText: Text(
                "選擇停靠站",
                style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 16,
                ),
              ),
              onConfirm: (results) {
                //_selectedAnimals = results;
                print(results);
              },
            ),
            const Divider(),
            Text('車廂'),
          ],
        ),
      ),
    );
  }
}

class TextInputCell extends StatelessWidget {
  const TextInputCell({
    this.title = '',
    this.onChanged,
    super.key,
  });
  final String title;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 1, child: Text(title)),
          Expanded(
            flex: 1,
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                // 设置边框样式
                border: OutlineInputBorder(
                  // 设置圆角
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Animal {
  final int id;
  final String name;

  Animal({
    required this.id,
    required this.name,
  });
}

List<Animal> _animals = [
  Animal(id: 1, name: "Lion"),
  Animal(id: 2, name: "Flamingo"),
  Animal(id: 3, name: "Hippo"),
  Animal(id: 4, name: "Horse"),
  Animal(id: 5, name: "Tiger"),
  Animal(id: 6, name: "Penguin"),
  Animal(id: 7, name: "Spider"),
  Animal(id: 8, name: "Snake"),
  Animal(id: 9, name: "Bear"),
  Animal(id: 10, name: "Beaver"),
  Animal(id: 11, name: "Cat"),
  Animal(id: 12, name: "Fish"),
  Animal(id: 13, name: "Rabbit"),
  Animal(id: 14, name: "Mouse"),
  Animal(id: 15, name: "Dog"),
  Animal(id: 16, name: "Zebra"),
  Animal(id: 17, name: "Cow"),
  Animal(id: 18, name: "Frog"),
  Animal(id: 19, name: "Blue Jay"),
  Animal(id: 20, name: "Moose"),
  Animal(id: 21, name: "Gecko"),
  Animal(id: 22, name: "Kangaroo"),
  Animal(id: 23, name: "Shark"),
  Animal(id: 24, name: "Crocodile"),
  Animal(id: 25, name: "Owl"),
  Animal(id: 26, name: "Dragonfly"),
  Animal(id: 27, name: "Dolphin"),
];
final _items = _animals
    .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
    .toList();
