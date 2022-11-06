import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_model.dart';

class Cart extends ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount => _items.length;

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, item) {
      total = total + item.price * item.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, int quantity, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (value) => CartItem(
            id: value.id,
            title: value.title,
            price: value.price,
            quantity: value.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            quantity: quantity,
            price: price),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (value) => CartItem(
            id: value.id,
            title: value.title,
            price: value.price,
            quantity: value.quantity - 1),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
