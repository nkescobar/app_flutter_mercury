import 'package:flutter/material.dart';

// Widgets Compartidos
import 'package:app_mercury_flutter/entrypoint/ui/shared/widgets/index.dart'
    show ProgressIndicatorWidget;

// Colores
import 'package:app_mercury_flutter/entrypoint/application/config/index.dart'
    show AppColors;

class ButtonIconWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final bool isLoading;

  const ButtonIconWidget({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 50.0,
      ),
      child: ElevatedButton(
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
            : Icon(
                icon,
                color: onPressed != null
                    ? AppColors.primaryColor
                    : Colors.black.withOpacity(0.4),
                size: 22.0,
              ),
      ),
    );
  }
}
