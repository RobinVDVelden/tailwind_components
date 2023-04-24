import 'package:flutter/material.dart';

import 'tw_colors.dart';

class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final String? label;
  final Color? color;
  final TextCapitalization? textCapitalization;
  final String? errorMessage;
  final Icon? suffixIcon;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final bool? obscureText;
  final bool? autofocus;
  final bool? autocorrect;
  final Function(String)? onChanged;
  final bool? readOnly;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final String? value;
  final List<Function>? validators;
  final bool? enableErrorIcon;

  const InputField({
    super.key,
    this.controller,
    this.placeholder,
    this.label,
    this.color, this.textCapitalization, this.errorMessage, this.suffixIcon,
    this.onEditingComplete,
    this.keyboardType,
    this.validator,
    this.autovalidateMode,
    this.obscureText,
    this.autofocus,
    this.autocorrect,
    this.onChanged,
    this.readOnly,
    this.onTap,
    this.value,
    this.validators,
    this.enableErrorIcon,
  });

  @override
  State<InputField> createState() => InputFieldState();
}

class InputFieldState extends State<InputField> {
  String? errorMessage;

  String? validate(val) {
    if (widget.validators != null) {
      for (Function validator in widget.validators!) {
        var result = validator(val);

        if (result != null) {
          WidgetsBinding.instance.addPostFrameCallback((_){
            setState(() {
              errorMessage = result.toString();
            });
          });
          return result;
        }
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_){
      setState(() {
        errorMessage = null;
      });
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null ? Text(widget.label!,
          style: const TextStyle(
              color: TWColors.gray_700,
              fontWeight: FontWeight.w500,
              fontSize: 14
          ),
        ) : Container(),
        SizedBox(height: widget.label != null ? 5 : 0),
        TextFormField(
          initialValue: widget.value,
          onTap: widget.onTap,
          readOnly: widget.readOnly ?? false,
          onChanged: widget.onChanged,
          autofocus: widget.autofocus ?? false,
          autocorrect: widget.autocorrect ?? false,
          obscureText: widget.obscureText ?? false,
          onEditingComplete: widget.onEditingComplete,
          textAlignVertical: TextAlignVertical.bottom,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          controller: widget.controller,
          textCapitalization: widget.textCapitalization ?? TextCapitalization.sentences,
          style: TextStyle(
            fontSize: 15,
            color: errorMessage != null ? TWColors.red_900 : null,
          ),
          validator: widget.validator ?? validate,
          autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.disabled,
          decoration: InputDecoration(
            errorText: errorMessage,
            errorStyle: const TextStyle(
                fontSize: 13,
                color: TWColors.red_500,
                fontWeight: FontWeight.w400
            ),
            suffixIcon: errorMessage != null && (widget.enableErrorIcon ?? false) ? const Icon(Icons.error, color: TWColors.red_500, size: 24) : widget.suffixIcon,
            isDense: true,
            contentPadding: const EdgeInsets.all(14),
            border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: TWColors.gray_300,
                ),
                borderRadius: BorderRadius.circular(6)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.2,
                  color: errorMessage != null ? TWColors.red_300 : TWColors.gray_300,
                ),
                borderRadius: BorderRadius.circular(6)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: errorMessage != null ? TWColors.red_500 : widget.color ?? TWColors.indigo_500,
                ),
                borderRadius: BorderRadius.circular(6)
            ),
            hintText: widget.placeholder,
            hintStyle: const TextStyle(
                fontSize: 14,
                color: TWColors.gray_500
            ),
          ),
        ),
      ],
    );
  }
}