import 'package:demo_state_management/providers/auth.dart';

import 'package:demo_state_management/providers/cart.dart';
import 'package:demo_state_management/providers/orders.dart';

import 'package:demo_state_management/providers/product_provider.dart';
import 'package:demo_state_management/screens/auth_screen.dart';
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
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductProvider>(
          create: (_) => ProductProvider('','', []),
          update: (_, auth, previousProduct) => ProductProvider(
              auth.token.toString(),
              auth.idUser.toString(),
              previousProduct == null ? [] : previousProduct.items),
        ),

        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Order>(
            create: (_) => Order('','', []),
            update: (_, auth, previousOrder) => Order(
              auth.token.toString(),
              auth.idUser.toString(),
              previousOrder == null? [] : previousOrder.orders),
            ),

      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
                .copyWith(secondary: Colors.deepOrangeAccent),
          ),
          home: auth.isAuth ? ProductsOverviewScreens() : AuthScreen(),
          // home: AuthScreen(),
          routes: {
            ProductDetailScreens.routeName: (ctx) => ProductDetailScreens(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routreName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
          },
        ),
      ),
    );
  }
}
