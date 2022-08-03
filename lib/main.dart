import 'package:demo_state_management/providers/cart.dart';
import 'package:demo_state_management/providers/orders.dart';
import 'package:demo_state_management/providers/product_provider.dart';
import 'package:demo_state_management/screens/cart_screens.dart';
import 'package:demo_state_management/screens/edit_product_screen.dart';
import 'package:demo_state_management/screens/orders_screen.dart';
import 'package:demo_state_management/screens/products_detail.dart';
import 'package:demo_state_management/screens/products_overview.dart';
import 'package:demo_state_management/screens/user_products_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:(_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create:(_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Order(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
              .copyWith(secondary: Colors.deepOrangeAccent),
        ),
        home: ProductsOverviewScreens(),
        routes: {
          ProductDetailScreens.routeName: (ctx) => ProductDetailScreens(),
          CartScreen.routeName: (ctx) => CartScreen(),
         OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routreName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
