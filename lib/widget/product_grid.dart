
import 'package:demo_state_management/providers/product_provider.dart';
import 'package:demo_state_management/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';

class ProductGrid extends StatelessWidget {
  final bool showFv;
  ProductGrid(this.showFv);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final product = showFv ? productData.favoriteItems : productData.items ;
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      // nen su dung ChangeNotifierProvider.value vi
      // no tu dong xoa du lieu khi khong can thiet
      // khac phuc loi tran du lieu.
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          // create: (ctx) => product[i],
        value: product[i],
          child: ProductItem()),
      itemCount: product.length,
    );
  }
}
