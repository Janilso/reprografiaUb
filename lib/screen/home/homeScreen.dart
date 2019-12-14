import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reprografiaub/utils/components/slidingUpDowPanel.dart';
import '../../utils/theme/style.dart';

class HomeScreen extends StatefulWidget {
  final title;

  HomeScreen({this.title});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Animation _arrowAnimation;
  Animation _color1Animation;
  Animation _color2Animation;
  Animation _creditsAnimation;

  AnimationController _arrowAnimationController;
  AnimationController _colorAnimationController;
  AnimationController _creditsAnimationController;

  Size screenSize;

  int credits = 100;

  @override
  void initState() {
    super.initState();

    _arrowAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _colorAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 10));
    _creditsAnimationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    _arrowAnimation =
        Tween(begin: 0.0, end: pi).animate(_arrowAnimationController);

    _color1Animation = ColorTween(begin: Colors.transparent, end: primaryColor)
        .animate(_colorAnimationController);
    _color2Animation = ColorTween(begin: Colors.transparent, end: secondary)
        .animate(_colorAnimationController);

    _creditsAnimation = IntTween(begin: 0, end: credits).animate(
        CurvedAnimation(
            parent: _creditsAnimationController, curve: Curves.easeOut));

    _creditsAnimationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenSize = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    super.dispose();
    _creditsAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: _buildInfoLayer(),
        ),
        floatingActionButton: new FloatingActionButton(
          backgroundColor: primaryColor,
          child: Icon(Icons.cached, color: Colors.white),
          onPressed: () => _creditsAnimationController.forward(from: 0),
        ),
      ),
    );
  }

  Widget _buildInfoLayer() {
    final maxHeight = screenSize.height > 750
        ? 0.60 * screenSize.height
        : 0.80 * screenSize.height;
    final minHeight = 70.0;
    final sizeQR = screenSize.width * 0.8;

    return SlidingUpDownPanel(
      color: Colors.transparent,
      boxShadow: null,
      slideDirection: SlideDirection.DOWN,
      maxHeight: maxHeight,
      minHeight: minHeight,
      parallaxEnabled: true,
      parallaxOffset: .5,
      panel: _panel(sizeQR, maxHeight),
      body: _bodyScren(),
      onPanelSlide: (double pos) {
        if (pos > 0.01 && pos < 0.03) {
          _colorAnimationController.animateTo(1);
        }
        _arrowAnimationController.animateTo(pos);
      },
      onPanelClosed: () {
        _colorAnimationController.animateTo(0);
      },
    );
  }

  Widget _panel(double sizeQR, double maxHeight) {
    return Stack(
      children: <Widget>[
        AnimatedBuilder(
            animation: _colorAnimationController,
            builder: (context, child) {
              return Container(
                height: maxHeight,
                width: screenSize.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [_color1Animation.value, _color2Animation.value],
                  ),
                  boxShadow: [
                    _colorAnimationController.value == 0
                        ? BoxShadow(color: Colors.transparent)
                        : BoxShadow(
                            color: Colors.black26,
                            blurRadius: 7.0,
                            spreadRadius: 5.0,
                            offset: Offset(0.0, 5.0),
                          ),
                  ],
                ),
              );
            }),
        Column(
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
                AnimatedBuilder(
                  animation: _arrowAnimationController,
                  builder: (context, child) => Transform.rotate(
                    angle: _arrowAnimation.value,
                    child: Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ],
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
                          AnimatedBuilder(
                              animation: _creditsAnimationController,
                              builder: (BuildContext context, Widget child) {
                                return Text(
                                  _creditsAnimation.value.toString(),
                                  style: textPointsPrimary,
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
