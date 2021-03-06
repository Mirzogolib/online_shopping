import 'package:flutter/material.dart';
import 'package:online_shopping/pages/splash_page.dart';
import 'package:online_shopping/providers/auth_provider.dart';
import './pages/adding_product_page.dart';
import './pages/cart_page.dart';
import './pages/orders_page.dart';
import './pages/user_products_page.dart';
import './providers/cart_provider.dart';
import './providers/orders_provider.dart';

import 'package:provider/provider.dart';

import './pages/product_detail_page.dart';
import './tools/constants.dart';
import './pages/products_overview_page.dart';
import 'providers/products_provider.dart';
import './pages/auth_page.dart';

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
          create: (ctx) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          update: (ctx, authProvider, productProvider) => ProductsProvider(
              authProvider.token,
              authProvider.userId,
              productProvider == null ? [] : productProvider.items),
          create: (ctx) => null,
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrderProvider>(
          update: (ctx, authProvider, orderProvider) => OrderProvider(
            authProvider.token,
            authProvider.userId,
            orderProvider == null ? [] : orderProvider.orders,
          ),
          create: (ctx) => null,
        )
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, authProvider, _) => MaterialApp(
          title: 'My Shop',
          theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato'),
          home: authProvider.isAuth
              ? ProductsOverviewPage()
              : FutureBuilder(
                  future: authProvider.canAutoLogIn(),
                  builder: (ctx, authResult) =>
                      authResult.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            Constants.productDetailRoute: (ctx) => ProductDetailPage(),
            Constants.cartRoute: (ctx) => CartPage(),
            Constants.orderRoute: (ctx) => OrdersPage(),
            Constants.userProductsRoute: (ctx) => UserProductsPage(),
            Constants.addingProductRoute: (ctx) => AddingProductPage(),
          },
        ),
      ),
    );
  }
}
