import 'package:flutter/foundation.dart';
import 'package:online_shopping/models/cart.dart';
import 'package:online_shopping/models/order.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double totalPrice) {
    _orders.insert(
      0,
      Order(
        id: DateTime.now().toString(),
        amount: totalPrice,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

 
}
