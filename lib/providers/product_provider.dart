import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class ProductProvider with ChangeNotifier {

  final String authToken;
  final String userId;
  ProductProvider(this.authToken,this.userId, this._items);

  List<Product> _items = [];


  List<Product> get items {
    return [..._items];
  }


  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite == true).toList();
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    String filterString = filterByUser ?  'orderBy="creatorId"&equalTo="$userId"' : '' ;
    var url = Uri.parse(
        'https://demostatem-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken&$filterString');
    try {

      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      //TODO: xu ly viec du lieu bi null.
      if(extractedData.isEmpty) {
        return;
      }
      url = Uri.parse(
          'https://demostatem-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorites/$userId.json?auth=$authToken');
      final responseFav = await http.get(url);
      final favoriteData = json.decode(responseFav.body);
      final List<Product> loadedProducts = [];

      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite: favoriteData == null ? false : favoriteData[prodId] ?? false,

        ));
      });

      _items = loadedProducts;

      print(json.decode(response.body));

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://demostatem-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
            'creatorId': userId,
          })).then((response) {
        final newProduct = Product(
            id: json.decode(response.body)['name'],
            title: product.title,
            description: product.description,
            price: product.price,
            imageUrl: product.imageUrl,
            isFavorite: product.isFavorite);
        _items.insert(0, newProduct);
        notifyListeners();
      });
    } catch (error) {
      rethrow;
    }
    // dang xu ly sync, ham post chay xong, goi lai then() xem co response ko
    // neu co moi xu ly tiep
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://demostatem-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$authToken');
      try {
        await http.patch(url,
            body: json.encode({
              'title': newProduct.title,
              'price': newProduct.price,
              'description': newProduct.description,
              'imageUrl': newProduct.imageUrl,
            }));
        _items[prodIndex] = newProduct;
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://demostatem-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$authToken');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      throw const HttpException('Could not delete product');
    }

  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
