import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  void addFavorite(dynamic object) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteObjects = prefs.getStringList('favoriteObjects') ?? [];
    favoriteObjects.add(object['name']);
    prefs.setStringList('favoriteObjects', favoriteObjects);
  }

  void removeFavorite(dynamic object) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteObjects = prefs.getStringList('favoriteObjects') ?? [];
    favoriteObjects.remove(object['name']); 
    prefs.setStringList('favoriteObjects', favoriteObjects);
  }

  Future<List<String>> getFavoriteobjects() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favoriteObjects') ?? [];
  }
}
