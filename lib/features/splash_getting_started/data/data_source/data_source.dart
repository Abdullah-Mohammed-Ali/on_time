import 'package:shared_preferences/shared_preferences.dart';

abstract class CashedDataSourceContract {
  Future<bool> setData(key, value);
  Future<dynamic> getData(key);
}

class CashedDataSource implements CashedDataSourceContract {
  final SharedPreferences _sharedPreferences;

  CashedDataSource(this._sharedPreferences);
  @override
  Future<dynamic> getData(key) async {
    return _sharedPreferences.get(key);
  }

  @override
  Future<bool> setData(key, value) async {
    if (value is bool) {
      return _sharedPreferences.setBool(key, value);
    }
    return false;
  }
}
