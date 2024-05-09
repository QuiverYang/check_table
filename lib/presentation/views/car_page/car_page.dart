import 'package:check_table/data/loader.dart';
import 'package:flutter/material.dart';

import '../pair_of_seats/pair_of_seats.dart';
import 'car_page_view_model.dart';

class CarPage extends StatefulWidget {
  const CarPage({super.key, required this.loader});

  final TrainLoader loader;

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  String title = 'loading...';
  CarPageViewModel? viewModel;

  List<Widget> leftSideSeats() {
    return viewModel?.leftSideSeatPairOfSeatViewModels
            .map((vm) => PairOfSeats(viewModel: vm))
            .toList() ??
        [];
  }

  List<Widget> rightSideSeats() {
    return viewModel?.rightSideSeatPairOfSeatViewModels
            .map((vm) => PairOfSeats(viewModel: vm))
            .toList() ??
        [];
  }

  @override
  void initState() {
    super.initState();
    widget.loader.load().then((train) {
      setState(() {
        viewModel = CarPageViewModelImp.fromTrain(train);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
          : Padding(
              key: UniqueKey(),
              padding:
                  const EdgeInsets.only(left: 4, right: 4, top: 0, bottom: 40),
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: leftSideSeats(),
                      ),
                    ),
                    Container(
                      height: 50.0 * viewModel!.rowNo,
                      width: 20,
                      color: Colors.grey,
                      alignment: Alignment.center,
                      child: const Text('走\n道'),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: rightSideSeats(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
