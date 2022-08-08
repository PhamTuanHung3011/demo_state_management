import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> loadDataOrder() async {
    final url = Uri.parse(
        'https://demovinhdeptrai-default-rtdb.firebaseio.com/orders.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if(extractedData.isEmpty) {
        return;
      }
      print(extractedData);
      final List<OrderItem> listOrderItems = [];


      extractedData.forEach((orderId, orderItems) {
        listOrderItems.add(OrderItem(
          id: orderId,
          amount: orderItems['amount'],
          dateTime: DateTime.parse(orderItems['dateTime']),
          products: (orderItems['products'] as List<dynamic>)
              .map((item) => CartItem(
              id: item['id'],
              title: item['title'],
              quantity: item['quantity'],
              price: item['price']),)
              .toList(),
        ));
      });
      _orders = listOrderItems.reversed.toList();
      notifyListeners();
    }catch(error) {
      rethrow;
    }

    // final List<Order> loadedOrder = [];
    // extractedData.forEach((cartId, cartData) {
    //   loadedOrder
    //       .add(OrderItem(dateTime: cartData['dateTime'], amount: cartData['amount'], id: cartId, products: []));
    // });
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    final url = Uri.parse(
        'https://demovinhdeptrai-default-rtdb.firebaseio.com/orders.json');
    try {
      final timeStamp = DateTime.now();
      final response = await http.post(url,
          body: json.encode({
            'amount': total,
            'dateTime': timeStamp.toIso8601String(),
            'products': cartProduct
                .map((e) => {
                      'id': e.id,
                      'title': e.title,
                      'price': e.price,
                      'quantity': e.quantity,
                    })
                .toList(),
          }));
      _orders.insert(
          0,
          OrderItem(
              id: json.decode(response.body)['name'],
              amount: total,
              products: cartProduct,
              dateTime: timeStamp));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
