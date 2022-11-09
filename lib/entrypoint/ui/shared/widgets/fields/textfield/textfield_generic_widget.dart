import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldGenericWidget extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextCapitalization textCapitalization;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? replaceText;
  final bool readOnly;
  final bool enabled;
  final bool obscureText;

  const TextFieldGenericWidget({
    Key? key,
    required this.controller,
    this.label,
    this.hintText,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.onSubmitted,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.replaceText,
    this.readOnly = false,
    this.enabled = true,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      readOnly: readOnly,
      enabled: enabled,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        errorMaxLines: 2,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
      ),
      onSubmitted: (value) {
        if (replaceText != null) {
          value = replaceText!(value);
        }
        onSubmitted!(value);
      },
      onChanged: (value) {
        if (replaceText != null) {
          value = replaceText!(value);
        }
        onChanged!(value);
      },
    );
  }
}
