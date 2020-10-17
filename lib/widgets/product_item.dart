import 'package:flutter/material.dart';
import 'package:online_shopping/pages/product_detail_page.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String productUrl;

  ProductItem(this.id, this.title, this.productUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailPage(title),
              ),
            );
          },
          child: Image.network(
            productUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(Icons.favorite_outline),
            onPressed: () {},
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
            title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
        ),
      ),
    );
  }
}
