import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/orders_model.dart';

import '../models/cart_model.dart';
import 'package:http/http.dart' as http;

class Orders extends ChangeNotifier {
  List<OrderItem> _orders = [];
  final String? authtoken;
  final String? userId;
  Orders(this.authtoken, this._orders, this.userId);

  List<OrderItem> get orders => [..._orders];

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://shop-app-50b1d-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authtoken');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];

    if (json.decode(response.body) == null) {
      return;
    }

    final extradtedData = json.decode(response.body) as Map<String, dynamic>;

    extradtedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  price: item['price'],
                  quantity: item['quantity']))
              .toList(),
          dateTime: DateTime.parse(orderData['dateTime'])));
    });

    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://shop-app-50b1d-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authtoken');
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
