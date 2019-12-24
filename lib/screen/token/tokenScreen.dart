import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reprografiaub/screen/home/homeScreen.dart';
import 'package:reprografiaub/utils/components/customButton.dart';
import 'package:reprografiaub/utils/components/customInputIcon.dart';
import 'package:reprografiaub/utils/components/loading.dart';
import 'package:reprografiaub/utils/theme/style.dart';

class TokenScreen extends StatefulWidget {
  @override
  _TokenScreenState createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen> {
  Size sizeScreen;
  bool _loading = false;

  fatchValidateToken() {
    setState(() => _loading = true);
    Timer(Duration(seconds: 5), () {
      setState(() => _loading = false);
      // Navigator.pushReplacement(
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: AppBar(
            elevation: 10.0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [primaryColor, secondary],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/logo-ub.png',
                      width: sizeScreen.width * 0.75),
                ],
              ),
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Vá até a central de\nrecarga para cadastrar\no seu Token",
                textAlign: TextAlign.center,
                style: textTitlePrimary,
              ),
              SizedBox(height: 40),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: sizeScreen.width * 0.1),
                child: CustomInputIcon(
                  hintText: "Token",
                  prefixIcon: Icons.vpn_key,
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 40),
              _loading
                  ? Loading()
                  : CustomButton(
                      text: "Cadastrar", onPressed: fatchValidateToken),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Todos os direitos reservados para\nUnibalsas - Faculdade de Balsas",
                style: textSubTitleGrey,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
