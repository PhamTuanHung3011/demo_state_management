import 'package:demo_state_management/widget/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Order;
import '../widget/app_drawer.dart';
import '../widget/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order-screens';

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    print('check ctx');

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Order'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<Order>(context, listen: false).loadDataOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Data Not Found'),
                );
              } else {
                return Consumer<Order>(builder: (ctx, orderData, child) => ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (ctx, i) => OrderItem(
                      orderData.orders[i],
                    )));
              }
            }
          },
        ));
  }
}
