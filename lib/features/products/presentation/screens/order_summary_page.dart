import 'package:h_food/export.dart';
import 'package:h_food/features/products/domain/entities/products.dart';
import 'package:h_food/features/products/presentation/bloc/products_bloc.dart';
import 'package:h_food/features/products/presentation/bloc/products_event.dart';
import 'package:h_food/features/products/presentation/bloc/products_state.dart';
import 'package:h_food/features/products/presentation/screens/order_product_card.dart';
import 'package:h_food/features/products/presentation/screens/product_card.dart';

class OrderSummaryPage extends StatefulWidget {
  const OrderSummaryPage({super.key, required this.totalCal});
  final num totalCal;
  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  ProductsBloc productsBloc = sl<ProductsBloc>();
  num cartPrice = 0;
  num cartCal = 0;

  @override
  void initState() {
    getSummary(productsBloc.cartList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.t.orderSummary),
      body: SafeArea(
        child: BlocConsumer<ProductsBloc, ProductsState>(
          bloc: productsBloc,
          buildWhen: (previous, current) => current is ProductsSuccess,
          listener: (context, state) {
            if (state is ProductsSuccess) {
              getSummary(state.cartList);
            }
          },
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
                  return OrderProductCard(
                      product: productsBloc.cartList[index]);
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
            if (state.orderResult['result'] != null &&
                state.orderResult['result']) {
              showSuccessSnack(message: context.t.orderIsSuccessful);
              context.pop();
            }
          }
        },
        builder: (context, state) {
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
                        ' $cartCal ${context.t.cal} ${context.t.outOf} ${widget.totalCal.toInt()} ${context.t.cal}',
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
                        '\$ $cartPrice',
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

  void getSummary(List<Product> cartList) {
    num cal = 0;
    num price = 0;
    for (var element in cartList) {
      cal += element.calories * element.quantity;
      price += element.price * element.quantity;
    }
    cartCal = cal;
    cartPrice = price;
  }
}
