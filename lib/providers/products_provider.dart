import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_shopping/tools/constants.dart';
import './product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  // var _isFavouriteNeeded = false;

  // void showFavouritesOnly(){
  //   _isFavouriteNeeded = true;
  //   notifyListeners();
  // }

  //   void showAll(){
  //   _isFavouriteNeeded = false;
  //   notifyListeners();
  // }

  List<Product> get items {
    // if(_isFavouriteNeeded){
    //   return _items.where((element) => element.isFavourite).toList();
    // }
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((element) => element.isFavourite == true).toList();
  }

  Product findProductById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addProduct(Product product) {
    final productUrl = Constants.mainAPI + 'products.json';
    return http
        .post(
      productUrl,
      body: json.encode(
        {
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavourite': product.isFavourite,
        },
      ),
      //needed action when response comes
    )
        .then((response) {
      final responseId = json.decode(response.body)['name'];
      if (responseId != null) {
        final newProduct = Product(
          title: product.title,
          description: product.description,
          imageUrl: product.imageUrl,
          price: product.price,
          id: responseId,
        );
        // inserts to end of the list
        _items.add(newProduct);
        // // inserts to top of the list
        // _items.insert(0, newPro duct);
        notifyListeners();
      }
    });
  }

  void updateProduct(String id, Product newProduct) {
    final editedProductIndex = _items.indexWhere((element) => element.id == id);
    if (editedProductIndex >= 0) {
      _items[editedProductIndex] = newProduct;
      notifyListeners();
    } else {
      print('product does not exist');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
