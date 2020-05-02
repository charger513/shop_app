import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop_app/models/http_exception.dart';

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

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final url =
        'https://shopapp-flutter-593c5.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';

    var oldStatus = isFavorite;

    isFavorite = !isFavorite;
    notifyListeners();

    try { // try catch for network errors
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );

      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
        throw HttpException('Could not favorite product.');
      } else {
        oldStatus = null;
      }
    } on SocketException catch(e) {
      print(e);
      _setFavValue(oldStatus);
    }
  }

  void _setFavValue(bool newStatus) {
    isFavorite = newStatus;
    notifyListeners();
  }
}
