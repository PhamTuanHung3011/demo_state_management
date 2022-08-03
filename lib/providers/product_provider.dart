import 'package:flutter/material.dart';

import '../data_fake/data_product.dart';
import 'product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _items = PRODUCT_DATA;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite == true).toList();
  }

  void addProduct(Product product) {
    final newProduct = Product(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite);
    // _items.add(newProduct);
    _items.insert(0, newProduct);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >=0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
