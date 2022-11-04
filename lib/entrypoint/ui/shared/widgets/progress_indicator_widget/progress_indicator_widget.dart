import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final Animation<Color>? valueColor;

  const ProgressIndicatorWidget({
    Key? key,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: valueColor,
    );
  }
}
