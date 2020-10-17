import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './pages/product_detail_page.dart';
import './tools/constants.dart';
import './pages/products_overview_page.dart';
import './providers/products.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: ProductsOverviewPage(),
        routes: {
          Constants.productDetailRoute: (ctx) => ProductDetailPage(title)
        },
      ),
    );
  }
}
