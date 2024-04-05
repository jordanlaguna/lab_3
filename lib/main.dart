// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => ShoppingCartBloc(),
        child: const ShoppingCartPage(),
      ),
    );
  }
}

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
        builder: (context, state) {
          if (state is ShoppingCartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ShoppingCartLoaded) {
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                );
              },
            );
          } else if (state is ShoppingCartError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Unknown state'),
            );
          }
        },
      ),
    );
  }
}

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  ShoppingCartBloc() : super(ShoppingCartLoading());

  @override
  Stream<ShoppingCartState> mapEventToState(ShoppingCartEvent event) async* {
    if (event is LoadShoppingCartItems) {
      yield* _mapLoadShoppingCartItemsToState();
    }
  }

  Stream<ShoppingCartState> _mapLoadShoppingCartItemsToState() async* {
    try {
      // Simulate an API call to fetch shopping cart items
      await Future.delayed(const Duration(seconds: 2));
      final items = [
        ShoppingCartItem(name: 'Item 1', price: 10.0),
        ShoppingCartItem(name: 'Item 2', price: 20.0),
        ShoppingCartItem(name: 'Item 3', price: 30.0),
      ];
      yield ShoppingCartLoaded(items: items);
    } catch (e) {
      yield ShoppingCartError(message: 'Failed to load shopping cart items');
    }
  }
}

abstract class ShoppingCartEvent {}

class LoadShoppingCartItems extends ShoppingCartEvent {}

abstract class ShoppingCartState {}

class ShoppingCartLoading extends ShoppingCartState {}

class ShoppingCartLoaded extends ShoppingCartState {
  final List<ShoppingCartItem> items;

  ShoppingCartLoaded({required this.items});
}

class ShoppingCartError extends ShoppingCartState {
  final String message;

  ShoppingCartError({required this.message});
}

class ShoppingCartItem {
  final String name;
  final double price;

  ShoppingCartItem({required this.name, required this.price});
}
