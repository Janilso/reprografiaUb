import 'dart:async';
import 'package:connectivity/connectivity.dart';

class Connection {
  static Future<bool> checkInternet() async {
    final status = await (Connectivity().checkConnectivity());
    return !(status == ConnectivityResult.none);
  }

  static Stream<ConnectivityResult> listenStatus() {
    return Connectivity().onConnectivityChanged;
  }
}
