import 'package:h_food/export.dart';
import 'package:h_food/features/products/domain/entities/products.dart';
import 'package:h_food/features/products/domain/usecases/products_usecase.dart';
import 'package:h_food/features/products/presentation/bloc/products_event.dart';
import 'package:h_food/features/products/presentation/bloc/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsUsecase productsUsecase;
  var meetList = <Product>[];
  var carbsList = <Product>[];
  var vegetablesList = <Product>[];
  var cartList = <Product>[];

  ProductsBloc({
    required this.productsUsecase,
  }) : super(ProductsEmpty()) {
    on<GetAllMeetEvent>(_getAllMeet);
    on<GetAllCarbsEvent>(_getAllCarbs);
    on<GetAllVegetablesEvent>(_getAllVegetables);
    on<AddToCart>(_addToCart);
    on<ConfirmOrderEvent>(_confirmOrder);
  }
  Future<void> _getAllMeet(
      GetAllMeetEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    final result = await productsUsecase.getAllMeet();
    result.fold(
      (failure) => emit(ProductsError(message: failure.message)),
      (success) {
        meetList = success.products;
        emit(ProductsSuccess(meetList: success.products));
      },
    );
  }

  Future<void> _getAllCarbs(
      GetAllCarbsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    final result = await productsUsecase.getAllCarbs();
    result.fold(
      (failure) => emit(ProductsError(message: failure.message)),
      (success) {
        carbsList = success.products;
        emit(ProductsSuccess(carbsList: success.products));
      },
    );
  }

  Future<void> _getAllVegetables(
      GetAllVegetablesEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    final result = await productsUsecase.getAllVegetables();
    result.fold(
      (failure) => emit(ProductsError(message: failure.message)),
      (success) {
        vegetablesList = success.products;
        emit(ProductsSuccess(vegetablesList: success.products));
      },
    );
  }

  Future<void> _addToCart(AddToCart event, Emitter<ProductsState> emit) async {
    if (cartList.contains(event.product)) {
      var product =
          event.product.copyWith(quantity: event.product.quantity + 1);
      cartList.remove(event.product);
      cartList.add(product);
    } else {
      cartList.add(event.product);
    }
    emit(ProductsSuccess(cartList: []));
    emit(ProductsSuccess(cartList: cartList));
  }

  Future<void> _confirmOrder(
      ConfirmOrderEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    final result = await productsUsecase.makeOrder(event.cart);
    result.fold(
      (failure) => emit(ProductsError(message: failure.message)),
      (success) {
        cartList = [];
        emit(ProductsSuccess(orderResult: success));
      },
    );
  }
}
