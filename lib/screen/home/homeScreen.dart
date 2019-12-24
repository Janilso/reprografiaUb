import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:reprografiaub/api/fetch.dart';
import 'package:reprografiaub/api/routes.dart';
import 'package:reprografiaub/api/storagePrefs.dart';
import 'package:reprografiaub/model/aluno.dart';
import 'package:reprografiaub/utils/components/loading.dart';
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
  Aluno aluno = Aluno(token: "123456");
  bool _loading = true;

  void getStorageAluno() {
    Storage.gett(Storage.aluno).then((onValue) {
      if (onValue != null) {
        final data = Aluno.fromJson(json.decode(onValue));
        setState(() {
          _loading = true;
          aluno = data;
        });
      }
      _fetchGetAluno();
    }).catchError((onError) {
      setState(() => _loading = false);
      print(onError);
    });
  }

  _fetchGetAluno() {
    setState(() => _loading = true);
    final url = Api.aluno + "/${aluno.token}";
    print("URL ==> $url");
    Fetch.gett(url).then((onValue) {
      print("ResultFatch ==> $onValue");
      final code = onValue['code'];
      if (code == 200) {
        final data = listAlunoFromJson(onValue['body']);
        setState(() {
          aluno = data;
          _loading = false;
        });
        
        _creditsAnimation =
            IntTween(begin: 0, end: aluno?.credito?.toInt() ?? 999).animate(
                CurvedAnimation(
                    parent: _creditsAnimationController,
                    curve: Curves.easeOutQuad));

        // _creditsAnimationController.forward();
        print("${aluno.nome} ${aluno.codAluno} ${aluno.criadoEm}");
        _creditsAnimationController.forward(from: 0);
      }
    }).catchError((onError) {
      setState(() => _loading = false);
      print(onError);
    });
  }

  @override
  void initState() {
    super.initState();
    getStorageAluno();
    _arrowAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _colorAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 10));
    _creditsAnimationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    _arrowAnimation =
        Tween(begin: 0.0, end: pi).animate(_arrowAnimationController);

    _color1Animation = ColorTween(begin: Colors.transparent, end: primaryColor)
        .animate(_colorAnimationController);
    _color2Animation = ColorTween(begin: Colors.transparent, end: secondary)
        .animate(_colorAnimationController);
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
          onPressed: _fetchGetAluno,
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
        _colorAnimationController.animateTo(1);
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
                    child: QrImage(
                        version: QrVersions.auto,
                        data: /* aluno?.token ??  */ "Alberto mizeravi, deu certo o QR",
                        gapless: true,
                        errorCorrectionLevel: QrErrorCorrectLevel.Q,
                        errorStateBuilder: (cnt, err) {
                          return Container(
                            child: Center(
                              child: Text("Uh oh! Erro ao carregar o QRcode...",
                                  textAlign: TextAlign.center),
                            ),
                          );
                        }),
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
                    _loading
                        ? Loading(white: true, size: 14.0, strokeWidth: 2.0)
                        : Text(aluno?.nome ?? "Nome", style: textTitle),
                    _loading
                        ? Loading(
                            white: true,
                            size: 12.0,
                            strokeWidth: 1.0,
                            padding: 8.0,
                          )
                        : Text(aluno?.codAluno ?? "00.0.00000",
                            style: textSubTitle),
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
                          _loading
                              ? Padding(
                                  padding: EdgeInsets.only(top: 30),
                                  child: Loading())
                              : AnimatedBuilder(
                                  animation: _creditsAnimationController,
                                  builder:
                                      (BuildContext context, Widget child) {
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
