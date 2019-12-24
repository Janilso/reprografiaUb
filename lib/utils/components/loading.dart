import 'package:flutter/material.dart';
import 'package:reprografiaub/utils/theme/style.dart';

class Loading extends StatelessWidget {
  final bool white;
  final double size;
  final double strokeWidth;
  final double padding;

  const Loading(
      {Key key, this.white = false, this.size, this.strokeWidth, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 0.0),
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
            strokeWidth: strokeWidth ?? 4.0,
            backgroundColor: primaryColor.withOpacity(0.5),
            valueColor: AlwaysStoppedAnimation<Color>(
                white ? whiteColor : primaryColor)),
      ),
    );
  }
}
