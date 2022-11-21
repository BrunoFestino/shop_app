import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/orders_provider.dart';
import 'package:shop_app/screens/auth/auth_screen.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/edit_product/edit_product_screen.dart';
import 'package:shop_app/screens/orders/orders_screen.dart';
import 'package:shop_app/screens/product_details/product_detail_screen.dart';
import 'package:shop_app/screens/splash_screen/splash_screen.dart';
import 'package:shop_app/screens/user_products/user_products_screen.dart';

import 'providers/products_provider.dart';
import 'screens/products_overview/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (context, auth, products) => Products(auth.getToken,
                products == null ? [] : products.items, auth.userId),
            create: (context) => Products('', [], ''),
          ),
          ChangeNotifierProvider(
            create: (context) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (context, auth, orders) => Orders(auth.getToken,
                orders == null ? [] : orders.orders, auth.userId),
            create: (context) => Orders('', [], ''),
          )
        ],
        child: Consumer<Auth>(
          builder: (context, value, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                          .copyWith(secondary: Colors.deepOrange),
                  fontFamily: 'Lato'),
              home: value.isAuth
                  ? const ProductOverviewScreen()
                  : FutureBuilder(
                      future: value.tryAutoLogin(),
                      builder: (context, snapshot) =>
                          snapshot.connectionState == ConnectionState.waiting
                              ? SplashScreen()
                              : AuthScreen(),
                    ),
              routes: {
                ProductDetailScreen.routeName: (ctx) =>
                    const ProductDetailScreen(),
                CartScreen.routeName: (ctx) => const CartScreen(),
                OrdersScreen.routeName: (ctx) => const OrdersScreen(),
                UserProductsScreen.routeName: (ctx) =>
                    const UserProductsScreen(),
                EditProductScreen.routeName: (ctx) => const EditProductScreen(),
              },
            );
          },
        ));
  }
}
