import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (ctx, i) => OrderItem(
              id: DateTime.now().toString(),
              amount: amount,
              products: products,
              dateTime: dateTime)),
    );
  }
}
