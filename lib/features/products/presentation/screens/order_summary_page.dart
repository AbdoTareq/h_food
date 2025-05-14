import 'package:elm_task/export.dart';
import 'package:elm_task/features/products/presentation/bloc/products_bloc.dart';
import 'package:elm_task/features/products/presentation/bloc/products_event.dart';
import 'package:elm_task/features/products/presentation/bloc/products_state.dart';
import 'package:elm_task/features/products/presentation/screens/product_card.dart';

class OrderSummaryPage extends StatefulWidget {
  const OrderSummaryPage({super.key, required this.totalCal});
  final num totalCal;
  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  ProductsBloc productsBloc = sl<ProductsBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.t.orderSummary),
      body: SafeArea(
        child: BlocBuilder<ProductsBloc, ProductsState>(
          bloc: productsBloc,
          buildWhen: (previous, current) => current is ProductsSuccess,
          builder: (context, state) {
            if (state is ProductsLoading) {
              return Center(child: const CircularProgressIndicator());
            }
            if (state is ProductsError) {
              return Text(state.message);
            }
            if (state is ProductsSuccess) {}
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                itemCount: productsBloc.cartList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return 10.heightBox;
                },
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(product: productsBloc.cartList[index]);
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BlocConsumer<ProductsBloc, ProductsState>(
        bloc: productsBloc,
        listener: (context, state) {
          if (state is ProductsSuccess) {
            Logger().i(state.orderResult);
            context.pop();
          }
        },
        builder: (context, state) {
          var cart = [];
          if (state is ProductsSuccess) {
            cart = state.cartList;
          }
          getCartPrice() {
            num price = 0;
            for (var element in cart) {
              price += element.price * element.quantity;
            }
            return price;
          }

          getCartCal() {
            num cal = 0;
            for (var element in cart) {
              cal += element.calories * element.quantity;
            }
            return cal;
          }

          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: kWhite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.t.cal),
                      Text(
                        ' ${getCartCal()} ${context.t.cal} ${context.t.outOf} ${widget.totalCal} ${context.t.cal}',
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  8.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.t.price.toTitleCase()),
                      Text(
                        '\$ ${getCartPrice()}',
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  8.heightBox,
                  RoundedCornerButton(
                    isLoading: state is ProductsLoading,
                    text: context.t.confirm,
                    onPressed: () {
                      var order = {
                        "items": productsBloc.cartList.map(
                          (e) {
                            return {
                              "name": e.foodName,
                              "total_price": e.price * e.quantity,
                              "quantity": e.quantity,
                            };
                          },
                        ).toList()
                      };
                      Logger().i(order);
                      sl<ProductsBloc>().add(ConfirmOrderEvent(order));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
