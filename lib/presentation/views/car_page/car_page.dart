import 'package:check_table/data/repos/train_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pair_of_seats/pair_of_seats.dart';
import 'car_page_view_model.dart';

class CarPage extends StatefulWidget {
  const CarPage({super.key});

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  String title = 'loading...';
  CarPageViewModel? viewModel;

  List<Widget> leftSideSeats(int index) {
    return viewModel?.carTableViewModels[index].leftSideSeatPairOfSeatViewModels
            .map((vm) => PairOfSeats(viewModel: vm))
            .toList() ??
        [];
  }

  List<Widget> rightSideSeats(int index) {
    return viewModel
            ?.carTableViewModels[index].rightSideSeatPairOfSeatViewModels
            .map((vm) => PairOfSeats(viewModel: vm))
            .toList() ??
        [];
  }

  @override
  void initState() {
    super.initState();
    final trainRepo = context.read<TrainRepository>();
    trainRepo.loadTrain();
  }

  @override
  Widget build(BuildContext context) {
    final trainRepo = context.watch<TrainRepository>();
    final currentTrain = trainRepo.currentTrain;
    if (currentTrain != null) {
      viewModel = CarPageViewModelImp.fromTrain(currentTrain);
      title = currentTrain.title;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  viewModel?.resetSeats();
                });
              },
              child: const Text('清除'))
        ],
      ),
      body: viewModel == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemCount: viewModel!.carTableViewModels.length,
              separatorBuilder: (cxt, index) => const Divider(),
              itemBuilder: (context, index) {
                return Padding(
                  key: UniqueKey(),
                  padding: const EdgeInsets.only(left: 4, right: 4, top: 0),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '車廂號碼：${viewModel!.carTableViewModels[index].carNo}',
                            style: Theme.of(context).textTheme.titleLarge,
                          )),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    children: leftSideSeats(index),
                                  ),
                                ),
                                Container(
                                  height: 50.0 * viewModel!.rowNo(index),
                                  width: 20,
                                  color: Colors.grey,
                                  alignment: Alignment.center,
                                  child: const Text('走\n道'),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    children: rightSideSeats(index),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
