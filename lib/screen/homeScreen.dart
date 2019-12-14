import 'package:flutter/material.dart';
import 'package:reprografiaub/utils/components/slidingUpDowPanel.dart';
import '../utils/theme/style.dart';

class HomeScreen extends StatefulWidget {
  final title;

  HomeScreen({this.title});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool changeColor = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: /* Stack( */
              // children: <Widget>[
              _buildInfoLayer(),
          // ],
          // ),
        ),
      ),
    );
  }

  Widget _buildInfoLayer() {
    final screenSize = MediaQuery.of(context).size;
    // print("Height===> ${screenSize.height}");
    final maxHeight = screenSize.height > 750
        ? 0.60 * screenSize.height
        : 0.80 * screenSize.height;
    final minHeight = 70.0;
    final sizeQR = screenSize.width * 0.8;

    final panel = Container(
        decoration: changeColor
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [primaryColor, secondary],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 7.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 5.0),
                  )
                ],
              )
            : BoxDecoration(),
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: sizeQR,
                    height: sizeQR,
                    color: Colors.white,
                    child: Image.asset("assets/images/qrcode.png"),
                  )
                ],
              ),
            ),
            SizedBox(height: 50.0),
            Text("Utilize o QRcode para usar \n seus créditos na reprografia.",
                style: textSubTitle, textAlign: TextAlign.center),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                    changeColor
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white)
              ],
            )
          ],
        ));

    return SlidingUpDownPanel(
      color: Colors.transparent,
      boxShadow: null,
      slideDirection: SlideDirection.DOWN,
      maxHeight: maxHeight,
      minHeight: minHeight,
      parallaxEnabled: true,
      parallaxOffset: .5,
      panel: panel,
      body: _bodyScren(),
      onPanelSlide: (double pos) {
        if (pos > 0.01 && pos < 0.03) setState(() => changeColor = true);
      },
      onPanelClosed: () {
        setState(() => changeColor = false);
      },
    );
  }

  Widget _bodyScren() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print("clickedsdaas");
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [primaryColor, secondary],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 7.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 5.0),
                  )
                ],
              ),
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.only(top: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Foto Perfil
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white54),
                          child: FractionallySizedBox(
                            widthFactor: 0.85,
                            heightFactor: 0.85,
                            child: Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                backgroundImage: ExactAssetImage(
                                    'assets/images/profile.jpg'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text("Alana Sousa", style: textTitle),
                    Text("20.1.11111", style: textSubTitle),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                Container(
                  height: 275,
                  width: 275,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15.0,
                          spreadRadius: 5.0,
                          offset: Offset(0.0, 0.0),
                        )
                      ],
                      color: Colors.white,
                      border: Border.all(color: primaryColor, width: 12),
                      shape: BoxShape.circle),
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 0.9,
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8.0,
                          spreadRadius: 3.0,
                          offset: Offset(0.0, 0.0),
                        )
                      ], color: Colors.white, shape: BoxShape.circle),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Créditos".toUpperCase(),
                              style: textSubTitlePrimary),
                          Text("888", style: textPointsPrimary),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Icon(Icons.cached, color: primaryColor, size: 35),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
