import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reprografiaub/api/helper.dart';
import 'package:reprografiaub/api/storagePrefs.dart';
import 'connection.dart';

class Fetch {
  static Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> data,
      [String auth]) async {
    bool con = await Connection.checkInternet();

    if (!con) {
      Fluttertoast.showToast(
          msg: 'Verifique sua Conexão', gravity: ToastGravity.CENTER);
      return {'code': 1000, 'body': "Sem conexão"};
    }

    try {
      Response response = await Dio()
          .post(url,
              data: FormData.fromMap(data),
              options:
                  Options(headers: {HttpHeaders.authorizationHeader: auth}))
          .timeout(Duration(seconds: 120));
      return {'code': response.statusCode, 'body': response.data};
    } on DioError catch (error) {
      if (error.type == DioErrorType.CONNECT_TIMEOUT ||
          error.type == DioErrorType.RECEIVE_TIMEOUT ||
          error.type == DioErrorType.SEND_TIMEOUT) {
        Fluttertoast.showToast(
            msg: 'Ocorreu um erro, tente novamente mais tarde',
            gravity: ToastGravity.CENTER);
      }
      print(error.response.data);
      return {
        'code': error.response.statusCode,
        'body': error.response.data.toString()
      };
    }
  }

  static Future<Map<String, dynamic>> putt(
      String url, Map<String, dynamic> data,
      [String auth]) async {
    bool con = await Connection.checkInternet();

    if (!con) {
      Fluttertoast.showToast(
          msg: 'Verifique sua Conexão', gravity: ToastGravity.CENTER);
      return {'code': 1000, 'body': "Sem conexão"};
    }
    try {
      Response response = await Dio()
          .put(url,
              data: data,
              options:
                  Options(headers: {HttpHeaders.authorizationHeader: auth}))
          .timeout(Duration(seconds: 120));
      return {'code': response.statusCode, 'body': response.data};
    } on DioError catch (error) {
      if (error.type == DioErrorType.CONNECT_TIMEOUT ||
          error.type == DioErrorType.RECEIVE_TIMEOUT ||
          error.type == DioErrorType.SEND_TIMEOUT) {
        Fluttertoast.showToast(
            msg: 'Ocorreu um erro, tente novamente mais tarde',
            gravity: ToastGravity.CENTER);
      }
      print(error.response.data);
      return {
        'code': error.response.statusCode,
        'body': error.response.data.toString()
      };
    }
  }

  static Future<Map<String, dynamic>> gett(String url,
      [String auth, bool save = true]) async {
    bool con = await Connection.checkInternet();

    if (!con) {
      Fluttertoast.showToast(
          msg: 'Verifique sua conexão', gravity: ToastGravity.CENTER);
      //var data = await Storage.gett(url);
      //var store = data == null ? null : jsonDecode(data);
      return {'code': 1000, 'body': "Sem conexão"};
    }

    try {
      Response response = await Dio()
          .get(url,
              options:
                  Options(headers: {HttpHeaders.authorizationHeader: auth}))
          .timeout(Duration(seconds: 120));

      //save or update response storage
      var data = {
        'code': response.statusCode,
        'body': response.data,
        'data': Helper.formatFromDateNow(true)
      };
      if (save) {
        Storage.save(url, jsonEncode(data));
      }

      return data;
    } on DioError catch (error) {
      if (error.type == DioErrorType.CONNECT_TIMEOUT ||
          error.type == DioErrorType.RECEIVE_TIMEOUT ||
          error.type == DioErrorType.SEND_TIMEOUT) {
        Fluttertoast.showToast(
            msg: 'Ocorreu um erro, tente novamente mais tarde',
            gravity: ToastGravity.CENTER);
      }
      print(error.response.data);
      return {
        'code': error.response.statusCode,
        'body': error.response.data.toString()
      };
    }
  }

  static Future<Map<String, dynamic>> delete(String url, [String auth]) async {
    bool con = await Connection.checkInternet();

    if (!con) {
      Fluttertoast.showToast(
          msg: 'Verifique sua Conexão', gravity: ToastGravity.CENTER);
      return {'code': 1000, 'body': "Sem conexão"};
    }

    try {
      Response response = await Dio()
          .delete(url,
              options:
                  Options(headers: {HttpHeaders.authorizationHeader: auth}))
          .timeout(Duration(seconds: 60));
      return {'code': response.statusCode, 'body': response.data};
    } on DioError catch (error) {
      if (error.type == DioErrorType.CONNECT_TIMEOUT ||
          error.type == DioErrorType.RECEIVE_TIMEOUT ||
          error.type == DioErrorType.SEND_TIMEOUT) {
        Fluttertoast.showToast(
            msg: 'Ocorreu um erro, tente novamente mais tarde',
            gravity: ToastGravity.CENTER);
      }
      print(error.response.data);
      return {
        'code': error.response.statusCode,
        'body': error.response.data.toString()
      };
    }
  }
}
