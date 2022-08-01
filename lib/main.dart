import 'package:demo_state_management/providers/product_provider.dart';
import 'package:demo_state_management/screens/products_detail.dart';
import 'package:demo_state_management/screens/products_overview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      create: (_) => ProductProvider(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
              .copyWith(secondary: Colors.deepOrangeAccent),
        ),
        home: ProductsOverviewScreens(),
        routes: {
ProductDetailScreens.routeName: (ctx) => ProductDetailScreens(),
        },
      ),
    );
  }
}
