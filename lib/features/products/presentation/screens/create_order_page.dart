import 'package:elm_task/core/view/widgets/old_fade_image.dart';
import 'package:elm_task/core/view/widgets/valid_button.dart';
import 'package:elm_task/export.dart';
import 'package:elm_task/features/products/domain/entities/products.dart';
import 'package:elm_task/features/products/presentation/bloc/products_bloc.dart';
import 'package:elm_task/features/products/presentation/bloc/products_event.dart';
import 'package:elm_task/features/products/presentation/bloc/products_state.dart';
import 'package:elm_task/features/products/presentation/screens/product_card.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key, required this.totalCal});
  final num totalCal;
  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  late ProductsBloc productsBloc;
  final isCartNotEmpty = ValueNotifier(false);

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
    return BlocProvider(
      create: (context) => productsBloc,
      child: Scaffold(
        appBar: CustomAppBar(title: context.t.createOrder),
        body: SafeArea(
          child: BlocConsumer<ProductsBloc, ProductsState>(
            listener: (context, state) {
              if (state is ProductsSuccess) {
                isCartNotEmpty.value = state.cartList.isNotEmpty;
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
                            return BlocProvider(
                              create: (context) => productsBloc,
                              child: ProductCard(
                                product: productsBloc.vegetablesList[index],
                              ),
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
        bottomNavigationBar: BlocBuilder<ProductsBloc, ProductsState>(
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
                    ValidButton(
                      isValid: isCartNotEmpty,
                      text: context.t.placeOrder,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
