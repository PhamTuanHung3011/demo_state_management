

import 'package:demo_state_management/providers/auth.dart';
import 'package:demo_state_management/screens/orders_screen.dart';
import 'package:demo_state_management/screens/user_products_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Order'),
            onTap: () {
              Navigator.pushReplacementNamed(context, OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit_note),
            title: Text('Manage products'),
            onTap: () {
              Navigator.pushNamed(context, UserProductsScreen.routreName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.login_outlined),
            title: Text('Log out'),
            onTap: () {

              Provider.of<Auth>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
