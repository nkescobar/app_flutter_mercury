import 'package:flutter/material.dart';

class IconButtonGenericWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const IconButtonGenericWidget({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
      ),
    );
  }
}
