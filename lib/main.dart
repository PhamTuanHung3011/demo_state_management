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
import 'package:demo_state_management/screens/splash_screen.dart';
import 'package:demo_state_management/screens/user_products_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>.value(
          value: Auth(),
        ),
        ChangeNotifierProvider<ProductProvider>.value(
            value: ProductProvider('', '', [])),
        ChangeNotifierProxyProvider<Auth, ProductProvider>(
          create: (_) => ProductProvider('0', '0', []),
          update: (_, auth, previousProduct) => ProductProvider(
              auth.token.toString(),
              auth.idUser.toString(),
              previousProduct == null ? [] : previousProduct.items),
        ),
        ChangeNotifierProvider<Cart>.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Order>(
          create: (_) => Order('', '', []),
          update: (_, auth, previousOrder) => Order(
              auth.token.toString(),
              auth.idUser.toString(),
              previousOrder == null ? [] : previousOrder.orders),
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
          home: auth.isAuth
              ? ProductsOverviewScreens()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? const SplashScreen()
                          : AuthScreen(),
                ),

          // home: AuthScreen(),
          routes: {
            AuthScreen.routeName: (_) => AuthScreen(),
            ProductDetailScreens.routeName: (_) => ProductDetailScreens(),
            CartScreen.routeName: (_) => const CartScreen(),
            OrdersScreen.routeName: (_) => OrdersScreen(),
            UserProductsScreen.routreName: (_) => const UserProductsScreen(),
            EditProductScreen.routeName: (_) => const EditProductScreen(),
          },
        ),
      ),
    );
  }
}
