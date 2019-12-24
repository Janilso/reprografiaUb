import 'package:flutter/material.dart';
import 'package:reprografiaub/utils/theme/style.dart';

class CustomInputIcon extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;
  final bool inputPassword;
  final IconData prefixIcon;

  CustomInputIcon({
    @required this.prefixIcon,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.inputPassword = false,
  });

  @override
  _CustomInputIconState createState() => _CustomInputIconState();
}

class _CustomInputIconState extends State<CustomInputIcon> {
  bool _visiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _visiblePassword,
        validator: widget.validator,
        cursorColor: primaryColor,
        style: inputCustomStyle,
        decoration: InputDecoration(
            prefixIcon: Icon(widget.prefixIcon,
                color: Color(getColorHexFromStr('#C00008')), size: 20.0),
            suffixIcon: widget.inputPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() => _visiblePassword = !_visiblePassword);
                    },
                    child: Icon(
                        _visiblePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: _visiblePassword
                            ? greyColor2
                            : Color(getColorHexFromStr('#C00008')),
                        size: 20.0),
                  )
                : null,
            fillColor: primaryColor.withOpacity(0.1),
            filled: true,
            border: InputBorder.none,
            focusColor: primaryColor,
            contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey)));
  }
}
