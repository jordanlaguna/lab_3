// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_3/bloc/cart_bloc.dart';
import 'package:lab_3/models/product.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Product> products = [
    Product(id: 1, name: "Coca-cola", price: 10),
    Product(id: 2, name: "Hamburguesa", price: 20),
    Product(id: 3, name: "Pizza", price: 30),
    Product(id: 4, name: "Hot Dog", price: 15),
    Product(id: 5, name: "Pasrel", price: 20),
    Product(id: 6, name: "Fanta Naranja", price: 30),
  ];

  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price}'),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                try {
                  BlocProvider.of<CartBloc>(context)
                      .add(AddToCart(CartItem(product: products[index])));
                  print(products[index].name + " added to cart");
                } catch (e) {
                  print(e.toString());
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartPage()),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de compras'),
      ),
      body: BlocBuilder<CartBloc, List<CartItem>>(
        builder: (context, cartItems) {
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cartItems[index].product.name),
                subtitle:
                    Text('\$${cartItems[index].product.price.toString()}'),
                trailing: IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    BlocProvider.of<CartBloc>(context)
                        .add(RemoveFromCart(cartItems[index]));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
