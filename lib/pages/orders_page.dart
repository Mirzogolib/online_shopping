import 'package:flutter/material.dart';
import 'package:online_shopping/providers/orders_provider.dart';
import 'package:online_shopping/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your orders',
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItem(
          ordersProvider.orders[i],
        ),
        itemCount: ordersProvider.orders.length,
      ),
    );
  }
}
