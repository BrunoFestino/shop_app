import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/screens/products_overview/widgets/product_Item_widget.dart';

import 'widgets/products_grid_widget.dart';

class ProductOverviewScreen extends StatelessWidget {
  ProductOverviewScreen({super.key});

  final List<Product> loadedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MyShop")),
      body: ProductsGrid(),
    );
  }
}
