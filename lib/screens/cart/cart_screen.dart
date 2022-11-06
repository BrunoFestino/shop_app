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
                  TextButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cartData.items.values.toList(), cartData.totalAmount);
                      cartData.clearCart();
                    },
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.itemCount,
              itemBuilder: (context, index) => cartData.items.isEmpty
                  ? Text('nodata')
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
