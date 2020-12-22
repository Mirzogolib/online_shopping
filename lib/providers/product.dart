import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:online_shopping/models/http_exception.dart';
import 'package:online_shopping/tools/constants.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  Future<void> toggleFavouriteStatus(String token) async {
    final updateProductUrl = Constants.mainAPI + 'products/$id.json?auth=$token';
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    try {
      final response = await http.patch(updateProductUrl,
          body: json.encode(
            {
              'isFavourite': isFavourite,
            },
          ));
      if (response.statusCode >= 400) {
        isFavourite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavourite = oldStatus;
      notifyListeners();
    }
  }
}
