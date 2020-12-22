import 'package:flutter/material.dart';
import 'package:online_shopping/pages/product_detail_page.dart';
import 'package:online_shopping/providers/auth_provider.dart';
import 'package:online_shopping/providers/cart_provider.dart';
import 'package:online_shopping/providers/product.dart';
import 'package:online_shopping/providers/products_provider.dart';
import 'package:online_shopping/tools/constants.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String productUrl;

  // ProductItem(this.id, this.title, this.productUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    final authData = Provider.of<AuthProvider>(context, listen: false);
    return ClipRRect(
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
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              icon: Icon(product.isFavourite
                  ? Icons.favorite
                  : Icons.favorite_outline),
              onPressed: () {
                try {
                  product.toggleFavouriteStatus(authData.token);
                } catch (error) {
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Toggle favourite failed!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
            ),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Item added to the cart!',
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
        ),
      ),
    );
  }
}
