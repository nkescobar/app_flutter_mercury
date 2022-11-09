import 'package:flutter/material.dart';

// Configurations
import 'package:app_mercury_flutter/entrypoint/application/config/index.dart'
    show AppColors;

// Widgets Compartidos
import 'package:app_mercury_flutter/entrypoint/ui/shared/index.dart'
    show ProgressIndicatorWidget;

class ButtonActionBordersWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const ButtonActionBordersWidget({
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
      child: OutlinedButton(
        onPressed: onPressed,
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
      ),
    );
  }
}
