import 'package:check_table/data/loaders/station_loader.dart';
import 'package:check_table/data/repos/train_repo.dart';
import 'package:check_table/models/car_table.dart';
import 'package:check_table/models/train.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/station.dart';

class AddTrainPage extends StatefulWidget {
  const AddTrainPage({super.key});

  @override
  State<AddTrainPage> createState() => _AddTrainPageState();
}

class _AddTrainPageState extends State<AddTrainPage> {
  @override
  Widget build(BuildContext context) {
    return Provider<Train>(
        create: (cxt) =>
            TrainImp(tables: [], stopStations: [], no: '1', title: ''),
        builder: (context, child) {
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
                      final repo =
                          Provider.of<TrainRepository>(context, listen: false);
                      // final train = await TrainImp.test();
                      final train = Provider.of<Train>(context, listen: false);
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
                    onChanged: (newValue) {
                      Provider.of<Train>(context, listen: false).title =
                          newValue;
                    },
                  ),
                  TextInputCell(
                    title: '2. 列車號碼',
                    onChanged: (newValue) {
                      Provider.of<Train>(context, listen: false).no = newValue;
                    },
                  ),
                  FutureBuilder<Map<String, Station>>(
                      future: LocalTrainStationLoader().load(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final stations = snapshot.data!;
                          final items = stations.keys
                              .map((stationNo) => MultiSelectItem<Station>(
                                  stations[stationNo]!,
                                  '${stations[stationNo]!.name}(${stations[stationNo]!.no})'))
                              .toList();
                          items.sort((a, b) =>
                              int.parse(a.value.no) - int.parse(b.value.no));

                          return MultiSelectDialogField(
                            items: items,
                            title: const Text("停靠站"),
                            selectedColor: Colors.blue,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
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
                            onConfirm: (stations) {
                              Provider.of<Train>(context, listen: false)
                                  .stopStations = stations;
                            },
                          );
                        } else if (snapshot.hasError) {
                          return const Center(child: Text('車站資料讀取錯誤'));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('新增車廂'),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              Provider.of<Train>(context, listen: false)
                                  .tables
                                  .add(ReservedCar.empty());
                            });
                          },
                          icon: const Icon(Icons.add))
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (cxt, index) => const Divider(),
                      itemBuilder: (cxt, index) {
                        return TableCard(
                            table: Provider.of<Train>(
                          context,
                        ).tables[index]);
                      },
                      itemCount: Provider.of<Train>(context).tables.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TableCard extends StatelessWidget {
  const TableCard({super.key, required this.table});

  final CarTable table;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.blue.shade50, // 背景色
          border: Border.all(
            color: Colors.black, // 边框颜色
          ),
          borderRadius: BorderRadius.circular(10), // 圆角半径
          boxShadow: [
            // 阴影
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            NumberDropdown(
                initialNumber: table.seatStartNo,
                title: '起始座位號碼',
                start: 1,
                end: 52,
                onChanged: (int value) {
                  table.setSeatStartNo(value);
                }),
            const SizedBox(height: 8),
            NumberDropdown(
                title: '結束座位號碼',
                initialNumber: table.seatEndNo,
                start: 1,
                end: 52,
                onChanged: (int value) {
                  table.setSeatEndNo(value);
                }),
            const SizedBox(height: 8),
            NumberDropdown(
                initialNumber: table.carNo,
                title: '車廂號碼',
                start: 1,
                end: 12,
                onChanged: (int value) {
                  table.carNo = value;
                  print(table.hashCode);
                }),
            SwitchInput(
              title: '是否需要反轉座號排列',
              initialValue: table.shouldReverse,
              onChanged: (bool value) {
                print('value: $value');
                print(table.hashCode);
                table.shouldReverse = value;
              },
            )
          ],
        ));
  }
}

class SwitchInput extends StatefulWidget {
  const SwitchInput(
      {super.key, required this.title, this.onChanged, this.initialValue});

  final String title;
  final bool? initialValue;
  final void Function(bool)? onChanged;

  @override
  State<SwitchInput> createState() => _SwitchInputState();
}

class _SwitchInputState extends State<SwitchInput> {
  bool value = true;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title),
        Switch(
          onChanged: (newValue) {
            widget.onChanged?.call(newValue);
            setState(() {
              value = newValue;
            });
          },
          value: value,
        )
      ],
    );
  }
}

class NumberDropdown extends StatefulWidget {
  const NumberDropdown(
      {super.key,
      required this.title,
      required this.start,
      required this.end,
      this.initialNumber,
      this.onChanged});

  final String title;
  final int start;
  final int end;
  final int? initialNumber;
  final void Function(int)? onChanged;

  @override
  State<NumberDropdown> createState() => _NumberDropdownState();
}

class _NumberDropdownState extends State<NumberDropdown> {
  var selectedValue = 1;

  List<int> get numbers {
    List<int> result = [];
    for (int i = widget.start; i <= widget.end; i++) {
      result.add(i);
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialNumber != null &&
        widget.initialNumber! >= widget.start &&
        widget.initialNumber! <= widget.end) {
      selectedValue = widget.initialNumber ?? 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 4, child: Text(widget.title)),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), // 设置圆角
              border: Border.all(),
              color: Colors.blue.shade100,
            ),
            child: DropdownButton<int>(
              value: selectedValue,
              alignment: Alignment.center,
              underline: Container(
                height: 0,
              ),
              isExpanded: true,
              borderRadius: BorderRadius.circular(4),
              onChanged: (int? newValue) {
                if (newValue == null) return;
                widget.onChanged?.call(newValue);
                setState(() {
                  selectedValue = newValue;
                });
              },
              selectedItemBuilder: (BuildContext context) {
                return numbers.map<Widget>((int value) {
                  return Center(child: Text(value.toString())); // 选中项居中显示
                }).toList();
              },
              items: numbers.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
