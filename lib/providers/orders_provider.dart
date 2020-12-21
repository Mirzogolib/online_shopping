import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:online_shopping/models/cart.dart';
import 'package:online_shopping/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:online_shopping/tools/constants.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  List<Order> get orders {
    return [..._orders];
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
