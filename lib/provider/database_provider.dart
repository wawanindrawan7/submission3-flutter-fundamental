import 'package:flutter/material.dart';
import 'package:submission_flutter/data/model/restaurant_list.dart';
import 'package:submission_flutter/helpers/database_helper.dart';
import 'package:submission_flutter/utils/request_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  late RequestState _state;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurants> _favorites = [];
  List<Restaurants> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.length > 0) {
      _state = RequestState.HasData;
    } else {
      _state = RequestState.NoData;
      _message = 'Restaurant Favorite Kamu\nBelum Ada';
    }
    notifyListeners();
  }

  void addFavorites(Restaurants restaurants) async {
    try {
      await databaseHelper.insertFavorite(restaurants);
      _getFavorites();
    } catch (e) {
      _state = RequestState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedRestaurant = await databaseHelper.getFavoriteById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = RequestState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
