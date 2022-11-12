import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/orders_model.dart';

import '../models/cart_model.dart';
import 'package:http/http.dart' as http;

class Orders extends ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://shop-app-50b1d-default-rtdb.firebaseio.com/orders.json');
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: jsonEncode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'quantity': e.quantity,
                    'price': e.price,
                  })
              .toList()
        }));
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: timestamp,
      ),
    );
    notifyListeners();
  }
}
