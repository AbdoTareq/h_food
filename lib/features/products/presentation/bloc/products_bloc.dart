import 'package:elm_task/export.dart';
import 'package:elm_task/features/products/domain/entities/products.dart';
import 'package:elm_task/features/products/domain/usecases/products_usecase.dart';
import 'package:elm_task/features/products/presentation/bloc/products_event.dart';
import 'package:elm_task/features/products/presentation/bloc/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsUsecase getAllProductsUsecase;
  var meetList = <Product>[];
  var carbsList = <Product>[];
  var vegetablesList = <Product>[];
  var cartList = <Product>[];

  ProductsBloc({
    required this.getAllProductsUsecase,
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
    final result = await getAllProductsUsecase.getAllMeet();
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
    final result = await getAllProductsUsecase.getAllCarbs();
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
    final result = await getAllProductsUsecase.getAllVegetables();
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
      ConfirmOrderEvent event, Emitter<ProductsState> emit) async {}
}
