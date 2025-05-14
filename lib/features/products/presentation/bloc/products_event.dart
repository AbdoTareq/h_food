import 'package:h_food/features/products/domain/entities/products.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProductsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllMeetEvent extends ProductsEvent {}

class GetAllCarbsEvent extends ProductsEvent {}

class GetAllVegetablesEvent extends ProductsEvent {}

class AddToCart extends ProductsEvent {
  final Product product;
  AddToCart(this.product);
}

class RemoveFromCart extends ProductsEvent {
  final Product product;
  RemoveFromCart(this.product);
}

class ConfirmOrderEvent extends ProductsEvent {
  final Map<String, dynamic> cart;
  ConfirmOrderEvent(this.cart);
}
