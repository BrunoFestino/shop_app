import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders_provider.dart';
import 'package:shop_app/screens/orders/widgets/order_item.dart';

import '../../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order-screen';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) {
          return OrderItemWidget(orderData.orders[index]);
        },
      ),
    );
  }
}
