import 'package:flutter/material.dart';
import 'package:online_shopping/providers/orders_provider.dart';
import 'package:online_shopping/widgets/app_drawer.dart';
import 'package:online_shopping/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  var _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<OrderProvider>(context, listen: false).fetchOrders();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your orders',
        ),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (ctx, i) => OrderItem(
                ordersProvider.orders[i],
              ),
              itemCount: ordersProvider.orders.length,
            ),
    );
  }
}
