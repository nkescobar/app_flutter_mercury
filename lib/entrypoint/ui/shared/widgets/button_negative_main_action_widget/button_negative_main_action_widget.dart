import 'package:flutter/material.dart';

// Widgets Compartidos
import 'package:app_mercury_flutter/entrypoint/ui/shared/widgets/index.dart'
    show ProgressIndicatorWidget;

// Colores
import 'package:app_mercury_flutter/entrypoint/application/config/index.dart'
    show AppColors;

class ButtonNegativeMainActionWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const ButtonNegativeMainActionWidget({
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
      child: ElevatedButton(
        // ignore: sort_child_properties_last
        child: isLoading
            ? const SizedBox(
                width: 25.0,
                height: 25.0,
                child: ProgressIndicatorWidget(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
              )
            : Text(
                text,
                style: onPressed != null
                    ? Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: AppColors.primaryColor,
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
