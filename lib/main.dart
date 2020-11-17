import 'package:flutter/material.dart';
import 'package:online_shopping/pages/cart_page.dart';
import 'package:online_shopping/pages/orders_page.dart';
import 'package:online_shopping/pages/user_products_page.dart';
import 'package:online_shopping/providers/cart_provider.dart';
import 'package:online_shopping/providers/orders_provider.dart';

import 'package:provider/provider.dart';

import './pages/product_detail_page.dart';
import './tools/constants.dart';
import './pages/products_overview_page.dart';
import 'providers/products_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderProvider(),
        )
      ],
      child: MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: ProductsOverviewPage(),
        routes: {
          Constants.productDetailRoute: (ctx) => ProductDetailPage(),
          Constants.cartRoute: (ctx) => CartPage(),
          Constants.orderRoute: (ctx) => OrdersPage(), 
          Constants.userProductsRoute: (ctx) => UserProductsPage(), 
        },
      ),
    );
  }
}
