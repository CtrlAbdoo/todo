import 'package:flutter/material.dart';

typedef Validator = Function(String?);

class CustomFormField extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final bool secureText;
  Validator? validator;
  TextEditingController? controller;
  int lines;
  CustomFormField({
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.secureText = false,
    this.validator,
    this.controller,
    this.lines = 1
  });

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final validator = widget.validator;
    if (validator is String? Function(String?)?) {
      return TextFormField(
        maxLines: widget.lines,
        minLines: widget.lines,
        controller: widget.controller,
        validator: validator,
        obscureText: widget.secureText && obscureText,
        obscuringCharacter: '*',
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.hintText,
          suffixIcon: widget.secureText
              ? IconButton(
                  icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                )
              : null,
        ),
      );
    } else {
      return TextFormField();
    }
  }
}
