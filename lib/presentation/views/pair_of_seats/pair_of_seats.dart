import 'package:flutter/material.dart';

import 'pair_of_seat_view_model.dart';

class PairOfSeats extends StatefulWidget {
  const PairOfSeats({super.key, required this.viewModel});

  final PairOfSeatViewModel viewModel;

  @override
  State<PairOfSeats> createState() => _PairOfSeatsState();
}

class _PairOfSeatsState extends State<PairOfSeats> {
  late PairOfSeatViewModel viewModel;
  final kCellHeight = 50.0;
  final Color cellBackgroundColor = Colors.blue.shade100;
  String leftValue = '';
  String rightValue = '';

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kCellHeight,
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
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), // 设置圆角
                  border: Border.all(),
                  color: cellBackgroundColor,
                ),
                child: DropdownButton<String>(
                  value: leftValue,
                  alignment: Alignment.center,
                  iconSize: 0,
                  underline: Container(
                    height: 0,
                  ),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(4),
                  onChanged: (String? newValue) {
                    setState(() {
                      leftValue = newValue ?? '';
                      viewModel.leftSeat.purpose = leftValue;
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return viewModel.destinations.map<Widget>((String value) {
                      return Center(child: Text(value)); // 选中项居中显示
                    }).toList();
                  },
                  items: viewModel.destinations
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              )),
          Expanded(
            flex: 1,
            child: Container(
                decoration: BoxDecoration(border: Border.all()),
                alignment: Alignment.center,
                child: Text(viewModel.rightSeat.no.toString())),
          ),
          Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4), // 设置圆角
                    border: Border.all(),
                    color: cellBackgroundColor),
                child: DropdownButton<String>(
                  value: rightValue,
                  alignment: Alignment.center,
                  iconSize: 0,
                  underline: Container(
                    height: 0,
                  ),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(4),
                  onChanged: (String? newValue) {
                    setState(() {
                      rightValue = newValue ?? '';
                      viewModel.rightSeat.purpose = rightValue;
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return viewModel.destinations.map<Widget>((String value) {
                      return Center(child: Text(value)); // 选中项居中显示
                    }).toList();
                  },
                  items: viewModel.destinations
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              )),
        ],
      ),
    );
  }
}
