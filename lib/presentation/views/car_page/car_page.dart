import 'package:check_table/data/loader.dart';
import 'package:flutter/material.dart';

import '../pair_of_seats/pair_of_seat_view_model.dart';
import '../pair_of_seats/pair_of_seats.dart';

abstract class CarPageViewModel {}

class CarPageViewModelImp extends CarPageViewModel {}

class CarPage extends StatefulWidget {
  const CarPage({super.key, required this.loader});

  final CarPageLoader loader;

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  String title = 'loading...';
  CarPageViewModel? viewModel;

  List<Widget> leftSideSeats() {
    return [
      PairOfSeats(viewModel: PairOfSeatViewModelImp.test()),
    ];
  }

  List<Widget> rightSideSeats() {
    return [
      PairOfSeats(viewModel: PairOfSeatViewModelImp.test()),
    ];
  }

  @override
  void initState() {
    super.initState();
    widget.loader.load().then((stationMap) {
      setState(() {
        viewModel = CarPageViewModelImp();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: viewModel == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: leftSideSeats(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: const Text('走\n道'),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: rightSideSeats(),
                  ),
                ),
              ],
            ),
    );
  }
}
