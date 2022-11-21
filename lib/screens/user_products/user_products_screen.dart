import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/user_products/widgets/user_product_item_widget.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../edit_product/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> _refreshProducts(BuildContext ctx) async {
      await Provider.of<Products>(context, listen: false)
          .fetchAndSetProducs(true);
    }

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<Products>(
                    builder: (context, value, _) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListView.builder(
                        itemCount: value.items.length,
                        itemBuilder: (_, i) {
                          return Column(
                            children: [
                              UserProductItem(
                                  value.items[i].id,
                                  value.items[i].title,
                                  value.items[i].imageUrl),
                              const Divider()
                            ],
                          );
                        },
                      ),
                    ),
                  ),
      ),
    );
  }
}
