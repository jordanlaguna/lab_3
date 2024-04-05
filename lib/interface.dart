import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_3/bloc/cart_bloc.dart';
import 'package:lab_3/models/product.dart';

class PageCart extends StatelessWidget {
  const PageCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de compras'),
      ),
      body: BlocBuilder<CartBloc, List<CartItem>>(
        builder: (context, cartItems) {
          int totalItems = 0;
          double totalPrice = 0.0;
          for (var item in cartItems) {
            totalItems += item.quantity;
            totalPrice += item.product.price * item.quantity;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total de productos en el carrito: $totalItems',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Precio total: \$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(cartItems[index].product.name),
                      subtitle: Text(
                          '\$${cartItems[index].product.price.toString()}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          BlocProvider.of<CartBloc>(context)
                              .add(RemoveFromCart(cartItems[index]));
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
