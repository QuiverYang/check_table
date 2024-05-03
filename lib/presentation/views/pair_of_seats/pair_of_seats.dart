import 'package:flutter/material.dart';

import 'pair_of_seat_view_model.dart';

class PairOfSeats extends StatefulWidget {
  const PairOfSeats({super.key, required this.viewModel});

  final PairOfSeatViewModelImp viewModel;

  @override
  State<PairOfSeats> createState() => _PairOfSeatsState();
}

class _PairOfSeatsState extends State<PairOfSeats> {
  late PairOfSeatViewModelImp viewModel;
  final kCellHeight = 50.0;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kCellHeight,
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              alignment: Alignment.center,
              child: Text(viewModel.leftSeat.no.toString()),
            ),
          ),
          Expanded(
            flex: 4,
            child: DropdownMenu(
              expandedInsets: const EdgeInsets.all(8),
              menuStyle: MenuStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return Colors.blue.shade50; // Default Color
                }),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
                  (Set<MaterialState> states) {
                    // You can add conditional logic based on the state here
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    );
                  },
                ),
              ),
              dropdownMenuEntries: viewModel.destinations
                  .map((value) => DropdownMenuEntry(value: value, label: value))
                  .toList(),
              onSelected: (value) {},
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              alignment: Alignment.center,
              child: const Text('1'),
            ),
          ),
          Expanded(
            flex: 4,
            child: DropdownMenu(
              expandedInsets: const EdgeInsets.all(8),
              menuStyle: MenuStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return Colors.blue.shade50; // Default Color
                }),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
                  (Set<MaterialState> states) {
                    // You can add conditional logic based on the state here
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    );
                  },
                ),
              ),
              dropdownMenuEntries: viewModel.destinations
                  .map((value) => DropdownMenuEntry(value: value, label: value))
                  .toList(),
              onSelected: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
