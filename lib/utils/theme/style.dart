import 'package:flutter/material.dart';

TextStyle textStyle = const TextStyle(
  color: const Color(0XFF000000),
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
);
TextStyle textStyleDisabled = const TextStyle(
  color: Colors.grey,
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
);

TextStyle textStyleWhite = const TextStyle(
  color: const Color(0XFFFFFFFF),
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
);

TextStyle textBoldBlack = const TextStyle(
  color: const Color(0XFF000000),
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
);

TextStyle textBoldWhite = const TextStyle(
  color: const Color(0XFFFFFFFF),
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
);

TextStyle textBlackItalic = const TextStyle(
  color: const Color(0XFF000000),
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  fontStyle: FontStyle.italic,
);

TextStyle textGrey = const TextStyle(
  color: Colors.grey,
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
);

TextStyle textGreyBold = const TextStyle(
  color: Colors.grey,
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
);

TextStyle textStyleBlue = const TextStyle(
  color: primaryColor,
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
);

TextStyle textStyleActive = const TextStyle(
  color: const Color(0xFFF44336),
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
);

TextStyle textStyleActive18 = const TextStyle(
  color: const Color(0xFFF44336),
  fontSize: 18.0,
  fontWeight: FontWeight.normal,
);

TextStyle textStyleValidate = const TextStyle(
  color: const Color(0xFFF44336),
  fontSize: 11.0,
  fontWeight: FontWeight.normal,
  fontStyle: FontStyle.italic,
);

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    title: base.title.copyWith(),
  );
}

TextStyle textGreen = const TextStyle(
  color: const Color(0xFF00c497),
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
);

TextStyle textPrimary = const TextStyle(
  color: Color(0xFFFFD428),
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
);

final ThemeData base = ThemeData.light();

ThemeData appTheme = new ThemeData(
  fontFamily: "Montserrat",
  primaryColor: primaryColor,
  buttonColor: primaryColor,
  indicatorColor: Colors.white,
  splashColor: Colors.white24,
  splashFactory: InkRipple.splashFactory,
  accentColor: const Color(0xFF13B9FD),
  canvasColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.white,
  errorColor: const Color(0xFFB00020),
  highlightColor: primaryColor,
  iconTheme: new IconThemeData(color: primaryColor),
  buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
  textTheme: _buildTextTheme(base.textTheme),
  primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
  accentTextTheme: _buildTextTheme(base.accentTextTheme),
);

Color textFieldColor = const Color.fromRGBO(168, 160, 149, 0.6);
const Color backgroundColor = const Color(0xffeeeeee);
const Color whiteColor = const Color(0XFFFFFFFF);
const Color blackColor = const Color(0XFF242A37);
const Color greyColor = const Color(0XFFF1F2F6);
const Color greyColor2 = Colors.grey;
const Color greyColor3 = Color(0XFF606060);
const Color activeColor = const Color(0xFFF44336);
const Color redColor = const Color(0xFFFF0000);
const Color buttonStop = const Color(0xFFF44336);
const Color primaryColor = const Color(0xFFC00008);
const Color secondary = const Color(0xFF670000);
const Color facebook = const Color(0xFF4267b2);
const Color googlePlus = const Color(0xFFdb4437);
const Color yellow = Colors.pinkAccent;
const Color green1 = Colors.lightGreen;
const Color green2 = Colors.green;
const Color blue1 = Colors.lightBlue;
const Color blue2 = Colors.blue;
const Color tim = Colors.deepPurple;
const Color tim2 = Colors.deepPurpleAccent;

const Color greenColor = const Color(0xFF00c497);
const Color colorOnline = const Color(0XFF009b00);
const Color colorOffline = const Color(0XFFe30303);

TextStyle textStyleSmall = const TextStyle(
    color: const Color.fromRGBO(255, 255, 255, 0.8),
    fontSize: 12.0,
    fontWeight: FontWeight.bold);

TextStyle headingWhite = new TextStyle(
  color: Colors.white,
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

TextStyle textTitle = new TextStyle(
  color: Colors.white,
  fontSize: 25.0,
  fontWeight: FontWeight.w500,
);
TextStyle textTitlePrimary = new TextStyle(
  color: primaryColor,
  fontSize: 25.0,
  fontWeight: FontWeight.w500,
);
TextStyle textPointsPrimary = new TextStyle(
  color: primaryColor,
  fontSize: 100.0,
  fontWeight: FontWeight.w500,
);

TextStyle textSubTitle = new TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  fontWeight: FontWeight.w300,
);
TextStyle textSubTitleGrey = new TextStyle(
  color: greyColor2,
  fontSize: 18.0,
  fontWeight: FontWeight.w300,
);
TextStyle textSubTitlePrimary = new TextStyle(
  color: primaryColor,
  fontSize: 18.0,
  fontWeight: FontWeight.w300,
);
TextStyle inputCustomStyle = TextStyle(
  backgroundColor: Colors.transparent,
  color: primaryColor,
  fontSize: 18.0,
  fontWeight: FontWeight.w400,
  decoration: TextDecoration.none,
);

TextStyle buttonCustomStyle = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
  fontWeight: FontWeight.w300,
);

const Color transparentColor = const Color.fromRGBO(0, 0, 0, 0.2);
const Color activeButtonColor = const Color.fromRGBO(43, 194, 137, 50.0);
const Color dangerButtonColor = const Color(0XFFf53a4d);

int getColorHexFromStr(String colorStr) {
  colorStr = "FF" + colorStr;
  colorStr = colorStr.replaceAll("#", "");
  int val = 0;
  int len = colorStr.length;
  for (int i = 0; i < len; i++) {
    int hexDigit = colorStr.codeUnitAt(i);
    if (hexDigit >= 48 && hexDigit <= 57) {
      val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 65 && hexDigit <= 70) {
      // A..F
      val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 97 && hexDigit <= 102) {
      // a..f
      val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
    } else {
      throw new FormatException("An error occurred when converting a color");
    }
  }
  return val;
}
