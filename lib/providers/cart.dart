import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  late Map<String, CartItem> _items;

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String id, String title, double price) {
    if (_items.containsKey(id)) {
      // neu da ton tai thi cong them
      _items.update(id, (exitsCartItem) => CartItem(id: exitsCartItem.id, title: exitsCartItem.title,quantity: exitsCartItem.quantity, price: exitsCartItem.price, ));
    } else {
      _items.putIfAbsent(
          id,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
  }
}
