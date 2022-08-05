import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite = false;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isFavorite,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
  }

  Future<void> toggleFavoriteStatus() async {
    bool oldStatus = isFavorite;
    isFavorite = !isFavorite;

    final url = Uri.parse(
        'https://demovinhdeptrai-default-rtdb.firebaseio.com/products/$id.json');
    try {
      final response = await http.patch(url,
          body: json.encode({
            'isFavorite': isFavorite,
          }));
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
         throw HttpException('Favorites not checked');
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
    notifyListeners();
  }
}
