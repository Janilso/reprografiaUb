import 'package:flutter/material.dart';
import 'package:reprografiaub/utils/theme/style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;
  final bool hasIcon;
  final IconData icon;
  final double width;

  CustomButton({
    @required this.onPressed,
    @required this.text,
    this.hasIcon = false,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width != null ? width < 150 ? 150 : width : 200,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [secondary, primaryColor],
        ),
      ),
      child: SizedBox.expand(
        child: FlatButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Visibility(
                child: Container(
                  child: Icon(icon, color: Colors.white),
                ),
                visible: hasIcon,
              ),
              Expanded(
                child: Text(
                  "$text".toUpperCase(),
                  style: buttonCustomStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
