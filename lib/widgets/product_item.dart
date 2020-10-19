import 'package:flutter/material.dart';
import 'package:online_shopping/pages/product_detail_page.dart';
import 'package:online_shopping/providers/product.dart';
import 'package:online_shopping/tools/constants.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String productUrl;

  // ProductItem(this.id, this.title, this.productUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return Consumer<Product>(
      builder: (ctx, product, child) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                Constants.productDetailRoute,
                arguments: product.id,
              );
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            leading: IconButton(
              icon: Icon(product.isFavourite
                  ? Icons.favorite
                  : Icons.favorite_outline),
              onPressed: () {
                product.toggleFavouriteStatus();
              },
              color: Theme.of(context).accentColor,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              onPressed: () {},
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.black87,
          ),
        ),
      ),
    );
  }
}
