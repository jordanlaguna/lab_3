import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_3/models/product.dart';

class CartBloc extends Bloc<CartEvent, List<CartItem>> {
  CartBloc() : super([]);

  @override
  Stream<List<CartItem>> mapEventToState(CartEvent event) async* {
    if (event is AddToCart) {
      yield* _mapAddToCartToState(event);
    } else if (event is RemoveFromCart) {
      yield* _mapRemoveFromCartToState(event);
    }
  }

  Stream<List<CartItem>> _mapAddToCartToState(AddToCart event) async* {
    // Crear una nueva lista con el nuevo elemento agregado
    List<CartItem> updatedCart = List.from(state)..add(event.item);
    // Emitir la nueva lista como el nuevo estado
    yield updatedCart;
  }

  Stream<List<CartItem>> _mapRemoveFromCartToState(
      RemoveFromCart event) async* {
    // Crear una nueva lista sin el elemento que se va a eliminar
    List<CartItem> updatedCart = List.from(state)..remove(event.item);
    // Emitir la nueva lista como el nuevo estado
    yield updatedCart;
  }
}

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final CartItem item;

  AddToCart(this.item);
}

class RemoveFromCart extends CartEvent {
  final CartItem item;

  RemoveFromCart(this.item);
}
