import 'package:shared_preferences/shared_preferences.dart';

class SearchCity {
  static Future<void> storeSearchCity(String? city) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('search_city', city!);
  }

  static Future<String> getSearchCity() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final city = preferences.getString('search_city');
    return city ?? 'naples';
  }
}
