
import 'package:shared_preferences/shared_preferences.dart';

class DB{

  static save(String key, dynamic value) async{
    final prefs = await SharedPreferences.getInstance();

    if(value is String){
      prefs.setString(key, value);
    }else if(value is int){
      prefs.setInt(key, value);
    }else if(value is double){
      prefs.setDouble(key, value);
    }else if(value is bool){
      prefs.setBool(key, value);
    }
  }

  static Future<dynamic> get(String key) async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  static Future<dynamic> remove(String key) async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

}