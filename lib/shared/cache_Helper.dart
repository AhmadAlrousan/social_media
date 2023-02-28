import 'package:shared_preferences/shared_preferences.dart';


class CacheHelper
{
 static Future<bool> setData({required String key , required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

static Future<bool> getDataTheme({required String key}) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   return prefs.getBool(key) ?? false;
 }




//receive


 static Future<bool>  saveData({required String key, required dynamic value,})async
 {
   SharedPreferences prefs = await SharedPreferences.getInstance();

   if(value is String){
      return prefs.setString(key, value);
   }
   else if(value is int ){
     return prefs.setInt(key, value);
   }else if(value is bool ){
     return prefs.setBool(key, value);
   }
   return prefs.setDouble(key, value);
 }


 static dynamic getData ({required String key}) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   return prefs.get(key) ;
 }

 static Future<bool> removeData({required String key})async
 {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   return prefs.remove(key) ;
 }
}

