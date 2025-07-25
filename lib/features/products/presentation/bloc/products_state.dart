// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:h_food/features/products/domain/entities/products.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProductsState extends Equatable {
  @override
  List<Object> get props => [];
}

// products
class ProductsEmpty extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsError extends ProductsState {
  final String message;

  ProductsError({required this.message});

  @override
  List<Object> get props => [message];
}

class ProductsSuccess extends ProductsState {
  final List<Product> meatList;
  final List<Product> carbsList;
  final List<Product> vegetablesList;
  final List<Product> cartList;
  final Map orderResult;

  ProductsSuccess({
    this.meatList = const [],
    this.carbsList = const [],
    this.vegetablesList = const [],
    this.cartList = const [],
    this.orderResult = const {},
  });

  @override
  List<Object> get props => [meatList, carbsList, vegetablesList, cartList];

  ProductsSuccess copyWith({
    List<Product>? meetList,
    List<Product>? carbsList,
    List<Product>? vegetablesList,
    List<Product>? cartList,
    Map? orderResult,
  }) {
    return ProductsSuccess(
      meatList: meetList ?? meatList,
      carbsList: carbsList ?? this.carbsList,
      vegetablesList: vegetablesList ?? this.vegetablesList,
      cartList: cartList ?? this.cartList,
      orderResult: orderResult ?? this.orderResult,
    );
  }
}
