import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/products_overview/widgets/badge_widget.dart';
import 'package:shop_app/screens/products_overview/widgets/product_Item_widget.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../../providers/products_provider.dart';
import 'widgets/products_grid_widget.dart';

enum FilterOptions {
  _Favorites,
  _All,
}

class ProductOverviewScreen extends StatefulWidget {
  ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyShop"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                if (value == FilterOptions._Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: FilterOptions._Favorites,
                child: Text('Only Favorites'),
              ),
              PopupMenuItem(
                value: FilterOptions._All,
                child: Text('Show All'),
              )
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) => Badge(
                value: cartData.itemCount.toString(),
                color: Colors.red,
                child: ch!),
            child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
