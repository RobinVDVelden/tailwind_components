import 'package:flutter/material.dart';

import '../tw_colors.dart';

class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? placeholder;
  final String? label;
  final Color? color;
  final TextCapitalization? textCapitalization;
  final String? errorMessage;
  final Widget? suffixIcon;
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
  final double? fieldWidth;
  final TextAlign? textAlign;

  const InputField({
    super.key,
    this.controller,
    this.focusNode,
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
    this.fieldWidth,
    this.textAlign,
  });

  @override
  State<InputField> createState() => InputFieldState();
}

class InputFieldState extends State<InputField> {
  String? errorMessage;

  @override
  void initState() {
    super.initState();
  }

  String? validate(val) {
    if (widget.errorMessage != null) {
      return null;
    }

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
        SizedBox(
          width: widget.fieldWidth,
          child: TextFormField(
            focusNode: widget.focusNode,
            textAlign: widget.textAlign ?? TextAlign.start,
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
            style: const TextStyle(
              fontSize: 15,
            ),
            validator: widget.validator ?? validate,
            autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.disabled,
            decoration: InputDecoration(
              errorText: null,
              errorStyle: const TextStyle(
                  fontSize: 0,
                  color: TWColors.red_500,
                  fontWeight: FontWeight.w400
              ),
              suffixIcon: widget.suffixIcon,
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
                    color: TWColors.gray_300,
                  ),
                  borderRadius: BorderRadius.circular(6)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: widget.color ?? TWColors.indigo_500,
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
        ),

        if (widget.errorMessage != null || errorMessage != null) Container(
          padding: EdgeInsets.only(top: 4),
          child: Text(widget.errorMessage ?? errorMessage ?? '', style: TextStyle(
              color: TWColors.red_500,
              fontWeight: FontWeight.w500,
              fontSize: 12
          )),
        ),
      ],
    );
  }
}