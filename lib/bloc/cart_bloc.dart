import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_3/models/product.dart';

class CartBloc extends Bloc<CartEvent, List<CartItem>> {
  CartBloc() : super([]);

  Stream<List<CartItem>> mapEventToState(CartEvent event) async* {
    if (event is AddToCart) {
      yield* _mapAddToCartToState(event);
    } else if (event is RemoveFromCart) {
      yield* _mapRemoveFromCartToState(event);
    }
  }

  Stream<List<CartItem>> _mapAddToCartToState(AddToCart event) async* {
    state.add(event.item);
    yield List.from(state);
  }

  Stream<List<CartItem>> _mapRemoveFromCartToState(
      RemoveFromCart event) async* {
    state.remove(event.item);
    yield List.from(state);
  }
}

abstract class CartEvent {
  
}

class AddToCart extends CartEvent {
  final CartItem item;

  AddToCart(this.item);
}

class RemoveFromCart extends CartEvent {
  final CartItem item;

  RemoveFromCart(this.item);
}
