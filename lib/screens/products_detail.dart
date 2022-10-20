import 'package:demo_state_management/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreens extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct =
        Provider.of<ProductProvider>(context, listen: false).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
              height: 350.0,
              width: double.infinity,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text('${loadedProduct.title}'),
            SizedBox(
              height: 10.0,
            ),
            Text(
              '${loadedProduct.price}',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 20.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              width: double.infinity,
              child: Text(
                '${loadedProduct.description}',
                style: const TextStyle(color: Colors.blueGrey, fontSize: 18.0),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            // TODO: thiet ke nut order de cart nhan duoc
          ],
        ),
      ),
    );
  }
}
