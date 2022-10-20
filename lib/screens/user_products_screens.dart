import 'package:demo_state_management/screens/edit_product_screen.dart';
import 'package:demo_state_management/widget/app_drawer.dart';
import 'package:demo_state_management/widget/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);
  static const routreName = '/user-products';

  Future<void> refreshProducts(BuildContext ctx) async {
    await Provider.of<ProductProvider>(ctx, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final userProducts = Provider.of<ProductProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your products'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, EditProductScreen.routeName,
                      arguments: '');
                },
                icon: Icon(Icons.add)),
          ],
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
          future: refreshProducts(context),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () => refreshProducts(ctx),
                  child: Consumer<ProductProvider>(
                    builder: (ctx , userProducts, _)
                    => Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                      child: ListView.builder(
                        itemCount: userProducts.items.length,
                        itemBuilder: (_, int index) => Column(
                          children: [
                            UserProductsItem(
                              id: userProducts.items[index].id,
                              title: userProducts.items[index].title,
                              imageUrl: userProducts.items[index].imageUrl,
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ));
  }
}
