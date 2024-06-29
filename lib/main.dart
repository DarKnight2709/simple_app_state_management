import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app_state_management/common/theme.dart';
import 'package:simple_app_state_management/models/cart.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_app_state_management/models/catalog.dart';
import 'package:simple_app_state_management/screens/login.dart';
import 'package:simple_app_state_management/screens/my_cart.dart';
import 'package:simple_app_state_management/screens/my_catalog.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => CartModel(), child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart){
            if(cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          }
        )
      ],
      child: MaterialApp.router(
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: _router(),
      ),
    );
  }
}


GoRouter _router(){
  return GoRouter(
    initialLocation: '/login',
    routes:[
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen()
      ),
      GoRoute(
        path: '/catalog',
        builder: (context, state) => const CatalogScreen(),
        routes: [
          GoRoute(
            path: 'cart',
            builder: (context, state) =>  const CartScreen(),

          )
        ]
      )
    ]
  );
}


