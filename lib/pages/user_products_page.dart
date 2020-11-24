import 'package:flutter/material.dart';
import 'package:online_shopping/providers/products_provider.dart';
import 'package:online_shopping/tools/constants.dart';
import 'package:online_shopping/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../widgets/user_product_item.dart';

class UserProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(Constants.addingProductRoute);
              })
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsProvider.items.length,
          itemBuilder: (_, index) => Column(
            children: [
              UserProductItem(
                productsProvider.items[index].id,
                productsProvider.items[index].title,
                productsProvider.items[index].imageUrl,
               ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
