import 'package:demo_state_management/widget/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/orders.dart' show Order;
import '../widget/app_drawer.dart';
import '../widget/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static const routeName = '/order-screens';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (ctx, i) => OrderItem(
            orderData.orders[i],
              )),
    );
  }
}
