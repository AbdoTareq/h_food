import 'package:h_food/core/view/widgets/valid_button.dart';
import 'package:h_food/export.dart';
import 'package:h_food/features/products/domain/entities/products.dart';
import 'package:h_food/features/products/presentation/bloc/products_bloc.dart';
import 'package:h_food/features/products/presentation/bloc/products_event.dart';
import 'package:h_food/features/products/presentation/bloc/products_state.dart';
import 'package:h_food/features/products/presentation/screens/product_card.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key, required this.totalCal});
  final num totalCal;
  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  late ProductsBloc productsBloc;
  final isMealComplete = ValueNotifier(false);
  num cartPrice = 0;
  num cartCal = 0;

  @override
  void initState() {
    super.initState();
    productsBloc = sl<ProductsBloc>()
      ..add(GetAllMeetEvent())
      ..add(GetAllCarbsEvent())
      ..add(GetAllVegetablesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.t.createOrder),
      body: SafeArea(
        child: BlocBuilder<ProductsBloc, ProductsState>(
          bloc: productsBloc,
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.t.vegetables,
                      style: context.textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: 190,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => 8.widthBox,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: productsBloc.vegetablesList.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: productsBloc.vegetablesList[index],
                          );
                        },
                      ),
                    ),
                    20.heightBox,
                    Text(
                      context.t.meats,
                      style: context.textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: 190,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => 8.widthBox,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: productsBloc.meetList.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: productsBloc.meetList[index],
                          );
                        },
                      ),
                    ),
                    20.heightBox,
                    Text(
                      context.t.carbs,
                      style: context.textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: 190,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => 8.widthBox,
                        scrollDirection: Axis.horizontal,
                        itemCount: productsBloc.carbsList.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: productsBloc.carbsList[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BlocConsumer<ProductsBloc, ProductsState>(
        bloc: productsBloc,
        listener: (context, state) {
          var cart = <Product>[];
          if (state is ProductsSuccess) {
            cart = state.cartList;
            num cal = 0;
            num price = 0;
            for (var element in cart) {
              cal += element.calories * element.quantity;
              price += element.price * element.quantity;
            }
            cartCal = cal;
            cartPrice = price;
            isMealComplete.value = cartCal >= widget.totalCal;
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
                  ValidButton(
                    isValid: isMealComplete,
                    text: context.t.placeOrder,
                    onPressed: () {
                      context.pushNamed(
                        Routes.orderSummary,
                        extra: widget.totalCal,
                      );
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
