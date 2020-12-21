import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:online_shopping/models/cart.dart';
import 'package:online_shopping/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:online_shopping/tools/constants.dart';
import 'package:online_shopping/widgets/order_item.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  List<Order> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final url = Constants.mainAPI + 'orders.json';
    final response = await http.get(url);
    final List<Order> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderItem) {
      loadedOrders.add(
        Order(
          id: orderId,
          amount: orderItem['amount'],
          dateTime: DateTime.parse(
            orderItem['dateTime'],
          ),
          products: (orderItem['products'] as List<dynamic>)
              .map(
                (e) => CartItem(
                    id: e['id'],
                    title: e['title'],
                    quantity: e['quantity'],
                    price: e['price']),
              )
              .toList(),
        ),
      );
    });

    _orders = loadedOrders;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double totalPrice) async {
    final url = Constants.mainAPI + 'orders.json';
    final timeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': totalPrice,
        'dateTime': timeStamp.toIso8601String(),
        'products': cartProducts
            .map((cartProduct) => {
                  'id': cartProduct.id,
                  'title': cartProduct.title,
                  'quantity': cartProduct.quantity,
                  'price': cartProduct.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      Order(
        id: json.decode(response.body)['name'],
        amount: totalPrice,
        products: cartProducts,
        dateTime: timeStamp,
      ),
    );
    notifyListeners();
  }
}
