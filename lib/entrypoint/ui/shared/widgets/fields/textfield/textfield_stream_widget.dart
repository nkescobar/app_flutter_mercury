import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldStreamWidget extends StatelessWidget {
  final Stream<String> stream;
  final String? label;
  final String? hintText;
  final TextCapitalization textCapitalization;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String Function(String)? replaceText;
  final bool readOnly;
  final bool enabled;
  final bool? obscureText;
  final int minLines;
  final int? maxLines;

  const TextFieldStreamWidget({
    Key? key,
    required this.stream,
    required this.controller,
    this.label,
    this.hintText,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.onSubmitted,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.suffixIcon,
    this.prefixIcon,
    this.replaceText,
    this.readOnly = false,
    this.enabled = true,
    this.obscureText = false,
    this.minLines = 1,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          readOnly: readOnly,
          enabled: enabled,
          obscureText: obscureText!,
          minLines: minLines,
          maxLines: maxLines,
          decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            errorText: snapshot.error as String?,
            errorMaxLines: 2,
            prefixIcon: prefixIcon,
            suffixIcon: ((snapshot.hasData &&
                        (snapshot.data?.trim().isNotEmpty ?? false)) ||
                    controller!.text != '')
                ? suffixIcon
                : null,
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
      },
    );
  }
}
