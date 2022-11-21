import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/screens/orders/orders_screen.dart';
import 'package:shop_app/screens/user_products/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
          ),
          const Divider(),
          ListTile(
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routeName),
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
          ),
          const Divider(),
          ListTile(
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.routeName),
            leading: const Icon(Icons.edit),
            title: const Text('Magage Products'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}
