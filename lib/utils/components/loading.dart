import 'package:flutter/material.dart';
import 'package:reprografiaub/utils/theme/style.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => CircularProgressIndicator(
      backgroundColor: primaryColor.withOpacity(0.5),
      valueColor: AlwaysStoppedAnimation<Color>(primaryColor));
}
