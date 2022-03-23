import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners(); // same as setState in stateful widget
  }

  void toggleFavoriteStatus(String token, String userId) async {
    final url = Uri.https(
      'flutter-update-75a4a-default-rtdb.firebaseio.com',
      '/userFavorites/$userId/$id.json',
      {'auth': token},
    );
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    try {
      final response = await http.put(
        url,
        body: json.encode(isFavorite),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
        throw HttpException('Could not favorite/unfavorite product.');
      }
    } catch (error) {
      // only throws own error with GET/POST request
      print(error);
      _setFavValue(oldStatus);
      throw error;
    }
  }
}
