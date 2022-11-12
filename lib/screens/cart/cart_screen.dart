import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/providers/cart_provider.dart';

import '../../providers/orders_provider.dart';
import 'widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const routeName = '/cart-screen';
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cartData.totalAmount}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  OrderButton(cartData: cartData),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.itemCount,
              itemBuilder: (context, index) => cartData.items.isEmpty
                  ? const Text('No Data')
                  : CartItemWidget(
                      cartData.items.values.toList()[index].id,
                      cartData.items.keys.toList()[index],
                      cartData.items.values.toList()[index].price,
                      cartData.items.values.toList()[index].quantity,
                      cartData.items.values.toList()[index].title),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    super.key,
    required this.cartData,
  });

  final Cart cartData;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cartData.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cartData.items.values.toList(),
                  widget.cartData.totalAmount);
              setState(() {
                _isLoading = false;
              });
              widget.cartData.clearCart();
            },
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Text(
              'ORDER NOW',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
    );
  }
}
