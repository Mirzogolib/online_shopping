import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Your orders',
          ),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<OrderProvider>(context, listen: false).fetchOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An error occurred('),
                );
              } else {
                Consumer<OrderProvider>(
                  builder: (ctx, ordersProvider, child) => ListView.builder(
                    itemBuilder: (ctx, i) => OrderItem(
                      ordersProvider.orders[i],
                    ),
                    itemCount: ordersProvider.orders.length,
                  ),
                );
              }
            }
          },
        ));
  }
}
