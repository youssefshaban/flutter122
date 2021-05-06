import 'package:shared_preferences/shared_preferences.dart';
class sharedToken{
  SharedPreferences prefs ;
  String _token;
  DateTime _dateTime;
  Future<void> setToken({String token, DateTime dateTime}) async {
     prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('datetime', dateTime.toString());
    _dateTime=dateTime;
    _token=token;
  }
  Future<String> gettoken() async {
    prefs = await SharedPreferences.getInstance();
    try{
      _token=await prefs.get('token');
      _dateTime=DateTime.parse(prefs.get('datetime'));
      if(_dateTime.isAfter(DateTime.now().add(Duration(days: 30)))){
        _token=null;
        _dateTime=null;
      }
    }catch(e){
      return _token;
    }

   return _token;

  }
  Future<void> logOut () async {
    await prefs.remove('token');
    await prefs.remove('datetime');
    return;
  }
}