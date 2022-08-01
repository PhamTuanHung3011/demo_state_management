import 'package:demo_state_management/widget/product_grid.dart';
import 'package:flutter/material.dart';

import '../data_fake/data_product.dart';
import '../providers/product.dart';

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
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    const PopupMenuItem(
                        child: Text('Favorites'),
                        value: FilterOption.Favorites),
                    const PopupMenuItem(
                        child: Text('Show All'), value: FilterOption.All),
                  ]),
        ],
      ),
      body: ProductGrid(_showOnlyFavorites),
    );
  }
}
