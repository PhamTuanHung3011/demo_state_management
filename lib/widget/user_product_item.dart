import 'package:demo_state_management/screens/edit_product_screen.dart';
import 'package:demo_state_management/screens/user_products_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../screens/products_detail.dart';

class UserProductsItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductsItem({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final scaffoldMess = ScaffoldMessenger.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreens.routeName,
          arguments: id,
        );
      },
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100.0,
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, EditProductScreen.routeName,
                      arguments: id);
                },
                icon: Icon(Icons.edit),
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                //TODO: cho user lua chon xoa hoac ko?
// da hoan thien boc showDialog trong nut delete
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Are your sure?'),
                    content: Text('Delete a product?'),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text('NO')),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await Provider.of<ProductProvider>(context,
                                    listen: false)
                                .deleteProduct(id);
                            scaffoldMess.showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Delete DONE!',
                                  textAlign: TextAlign.center,
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } catch (error) {
                            scaffoldMess.showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Delete failed',
                                  textAlign: TextAlign.center,
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: Text('YES'),
                      ),
                    ],
                    elevation: 10.0,
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.white24),
                    ),
                  ),
                  barrierDismissible: false,
                ),
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
