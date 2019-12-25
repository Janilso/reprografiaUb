import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reprografiaub/api/fetch.dart';
import 'package:reprografiaub/api/routes.dart';
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
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Size sizeScreen;
  bool _loading = false;
  TextEditingController _tokenCtl = TextEditingController();

  bool _autovalidate = false;

  fetchValidateToken() {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      setState(() {
        _loading = false;
        _autovalidate = true;
      });
    } else {
      setState(() => _loading = true);
      Map<String, dynamic> data = {"token": _tokenCtl.text};
      // Fetch.post(Api.login, data).then((onValue) {
      //   final code = onValue['code'];
      //   print("ResponseToken ==> $onValue");
      //   if (code == 200) {
      //     final response = onValue['body'];
      //     setState(() => _loading = false);
      //     // Navigator.pushReplacement(
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
      //     );
      //   }
      // }).catchError((onError) {
      //   setState(() => _loading = false);
      //   print(onError);
      //   Timer(Duration(seconds: 2), () {
      //     setState(() => _loading = false);
      //     // Navigator.pushReplacement(
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
      //     );
      //   });
      // });
      Timer(Duration(seconds: 2), () {
        setState(() => _loading = false);
        // Navigator.pushReplacement(
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
        );
      });
    }
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
                child: Form(
                  key: formKey,
                  autovalidate: _autovalidate,
                  child: CustomInputIcon(
                    hintText: "Token",
                    prefixIcon: Icons.vpn_key,
                    keyboardType: TextInputType.number,
                    controller: _tokenCtl,
                    validator: (value) =>
                        value.isEmpty ? 'Digite o Token.' : null,
                  ),
                ),
              ),
              SizedBox(height: 40),
              _loading
                  ? Loading()
                  : CustomButton(
                      text: "Cadastrar", onPressed: fetchValidateToken),
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
