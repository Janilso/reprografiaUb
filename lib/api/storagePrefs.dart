import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static final String aluno = 'aluno';

  static Future<bool> save(String key, String data) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, data);
  }

  static Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future<String> gett(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> clear() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  // static Future<Aluno> getAluno() async {
  //   final data = await gett(aluno);
  //   return data != null ? Aluno.fromJson(json.decode(data)) : null;
  // }
}
