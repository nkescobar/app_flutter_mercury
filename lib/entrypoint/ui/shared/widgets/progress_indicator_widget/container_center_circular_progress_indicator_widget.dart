import 'package:flutter/material.dart';
import 'package:app_mercury_flutter/entrypoint/ui/shared/widgets/progress_indicator_widget/constants/index.dart';

// Strings
class ContainerCenterCircularProgressIndicator extends StatelessWidget {
  final String text;

  const ContainerCenterCircularProgressIndicator({
    Key? key,
    this.text = ProgressIndicatorStrings.textCircularIndicatorDefect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(text)),
          const SizedBox(height: 10.0),
          const Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
