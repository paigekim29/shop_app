import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Products(), // builder for below ^4.0.0 version
      // better to use create because you create a new object
      // based on a class and notify provider for change
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}

// ChangeNotifierProvider allows us to register a class to which you can 
// listen in child widgets and whenever that class updates, only child widgets
// that are listening will be rebuilt
// can cause bug if items go beyond screen boundaries bc widgets are recycled
// and your data changes and your provider wouldn't keep up with that

// ChangeNotifierProvider.value should be used where you have the provider
// package and you're providing your data on a single list or grid items
// where Flutter recycle the widgets that attached to provider