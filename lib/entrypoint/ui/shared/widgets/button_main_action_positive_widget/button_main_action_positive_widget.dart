import 'package:flutter/material.dart';
// Configurations
import 'package:app_mercury_flutter/entrypoint/application/config/index.dart'
    show AppColors;

// Widgets Compartidos
import 'package:app_mercury_flutter/entrypoint/ui/shared/index.dart'
    show ProgressIndicatorWidget;

class ButtonMainActionPositiveWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const ButtonMainActionPositiveWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
      ),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.greyColor;
            }
            return AppColors.primaryColor;
          }),
          overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.pressed)) {
              return AppColors.primaryColor.shade900;
            }
            return Colors.transparent;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        // ignore: sort_child_properties_last
        child: isLoading
            ? const SizedBox(
                width: 25.0,
                height: 25.0,
                child: ProgressIndicatorWidget(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
                ),
              )
            : Text(
                text,
                style: onPressed != null
                    ? Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        )
                    : Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.black.withOpacity(0.4),
                          fontWeight: FontWeight.normal,
                        ),
              ),
        onPressed: onPressed,
      ),
    );
  }
}
