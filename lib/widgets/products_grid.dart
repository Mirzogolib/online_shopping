import 'package:flutter/material.dart';
import 'package:online_shopping/providers/product.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool isFavourite;
  ProductsGrid(this.isFavourite);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    final products =
        isFavourite ? productData.favouriteItems : productData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            ),
      ),
    );
  }
}
