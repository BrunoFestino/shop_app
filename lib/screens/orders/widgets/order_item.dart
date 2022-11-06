import 'dart:math';

import 'package:flutter/material.dart';

import 'package:shop_app/models/orders_model.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderItem order;
  const OrderItemWidget(this.order, {super.key});

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
              widget.order.dateTime.toString(),
            ),
            trailing: IconButton(
              icon: Icon(
                  _expanded == true ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(
                  () {
                    _expanded = !_expanded;
                  },
                );
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.products.length * 25.0 + 10, 100),
              child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.order.products[index].title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${widget.order.products[index].quantity}x \$ ${widget.order.products[index].price}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
