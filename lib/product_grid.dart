import 'package:flutter/material.dart';

class ProductGridBuilder extends StatelessWidget {
  final IndexedWidgetBuilder builder;
  final int itemCount;
  final BorderRadius borderRadius;
  final double columnGap;
  final double verticalGap;
  final double rightColumnYOffset;

  final List<Widget> leftColumn = [];
  final List<Widget> rightColumn = [];

  ProductGridBuilder({
    @required this.builder,
    @required this.itemCount,
    this.borderRadius,
    this.columnGap = 10,
    this.verticalGap = 10,
    this.rightColumnYOffset = 120,
  }) {
    _setup();
  }

  _setup() {
    leftColumn.clear();
    rightColumn.clear();

    // add a right offset if it's greater than 0
    if (rightColumnYOffset > 0) {
      rightColumn.add(SizedBox(
        height: rightColumnYOffset,
      ));
    }

    // When true, add it to the left column, when false, right
    bool flipSwitch = true;
    for (int i = 0; i < itemCount; i++) {
      if (flipSwitch) {
        leftColumn.add(builder(null, i));
        leftColumn.add(SizedBox(height: columnGap));
        flipSwitch = !flipSwitch;
      } else {
        rightColumn.add(builder(null, i));
        rightColumn.add(SizedBox(height: columnGap));
        flipSwitch = !flipSwitch;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Column(
          children: leftColumn,
        ),
        SizedBox(
          width: columnGap,
        ),
        Column(
          children: rightColumn,
        ),
      ],
    );
  }
}
