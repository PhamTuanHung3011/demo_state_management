import 'package:demo_state_management/providers/cart.dart';
import 'package:demo_state_management/screens/cart_screens.dart';
import 'package:demo_state_management/widget/badge.dart';
import 'package:demo_state_management/widget/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data_fake/data_product.dart';
import '../providers/product.dart';
import '../widget/app_drawer.dart';

enum FilterOption {
  Favorites,
  All,
}

class ProductsOverviewScreens extends StatefulWidget {
  @override
  State<ProductsOverviewScreens> createState() =>
      _ProductsOverviewScreensState();
}

class _ProductsOverviewScreensState extends State<ProductsOverviewScreens> {
  bool _showOnlyFavorites = false;
  final List<Product> loadedProducts = PRODUCT_DATA;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('State Management'),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FilterOption selectedValue) {
                setState(() {
                  if (selectedValue == FilterOption.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    const PopupMenuItem(
                        value: FilterOption.Favorites,
                        child: Text('Favorites')),
                    const PopupMenuItem(
                        value: FilterOption.All, child: Text('Show All')),
                  ]),
          Consumer<Cart>(
            builder: (
              _,
              cart,
              ch,
            ) =>
                Badge(
                    child: ch!,
                    value: cart.itemCount.toString(),
                    color: Theme.of(context).colorScheme.secondary),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(_showOnlyFavorites),
    );
  }
}
