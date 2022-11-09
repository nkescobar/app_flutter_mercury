import 'package:app_mercury_flutter/entrypoint/ui/shared/widgets/button_icon_widget/button_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_mercury_flutter/entrypoint/ui/shared/enums/index.dart';
import 'package:app_mercury_flutter/entrypoint/ui/shared/widgets/index.dart'
    show
        ButtonActionBordersWidget,
        ButtonNegativeMainActionWidget,
        ButtonMainActionPositiveWidget,
        ButtonActionSecundaryWidget;

class ButtonStreamLoadingWidget extends StatelessWidget {
  final ButtonTypeEnum buttonTypeEnum;
  final Stream<bool> isLoading;
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;

  const ButtonStreamLoadingWidget(
      {Key? key,
      required this.buttonTypeEnum,
      required this.isLoading,
      required this.text,
      this.onPressed,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: isLoading,
        builder: (context, snapshotLoading) {
          switch (buttonTypeEnum) {
            case ButtonTypeEnum.buttonActionBorders:
              return ButtonActionBordersWidget(
                  text: text,
                  isLoading: snapshotLoading.data ?? false,
                  onPressed: snapshotLoading.data == false ||
                          snapshotLoading.data == null
                      ? onPressed
                      : null);

            case ButtonTypeEnum.buttonActionMainNegative:
              return ButtonNegativeMainActionWidget(
                  text: text,
                  isLoading: snapshotLoading.data ?? false,
                  onPressed: snapshotLoading.data == false ||
                          snapshotLoading.data == null
                      ? onPressed
                      : null);
            case ButtonTypeEnum.buttonActionMainPositive:
              return ButtonMainActionPositiveWidget(
                  text: text,
                  isLoading: snapshotLoading.data ?? false,
                  onPressed: snapshotLoading.data == false ||
                          snapshotLoading.data == null
                      ? onPressed
                      : null);
            case ButtonTypeEnum.buttonActionMainSecundary:
              return ButtonActionSecundaryWidget(
                  text: text,
                  isLoading: snapshotLoading.data ?? false,
                  onPressed: snapshotLoading.data == false ||
                          snapshotLoading.data == null
                      ? onPressed
                      : null);
            case ButtonTypeEnum.buttonIconWidget:
              return ButtonIconWidget(
                  icon: icon!,
                  isLoading: snapshotLoading.data ?? false,
                  onPressed: snapshotLoading.data == false ||
                          snapshotLoading.data == null
                      ? onPressed
                      : null);

            default:
              {
                return Container();
              }
          }
        });
  }
}
