import 'package:h_food/core/view/widgets/my_list_tile.dart';
import 'package:h_food/core/view/widgets/old_fade_image.dart';
import 'package:h_food/export.dart';
import 'package:h_food/features/products/domain/entities/products.dart';
import 'package:h_food/features/products/presentation/bloc/products_bloc.dart';
import 'package:h_food/features/products/presentation/bloc/products_event.dart';

class OrderProductCard extends StatelessWidget {
  const OrderProductCard({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: kWhite,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MyListTile(
          leading: SizedBox(
            width: .3.sw,
            height: 90,
            child: FadeImage(imagePath: product.imageUrl),
          ),
          children: [
            8.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(product.foodName), Text('\$12')],
            ),
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${product.calories} ${context.t.cal}',
                  style: context.textTheme.bodySmall,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: product.quantity > 0
                          ? () =>
                              sl<ProductsBloc>().add(RemoveFromCart(product))
                          : null,
                      child: const Icon(
                        Icons.remove_circle,
                        color: kPrimaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('${product.quantity}'),
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.add_circle,
                        color: kPrimaryColor,
                      ),
                      onTap: () => sl<ProductsBloc>().add(AddToCart(product)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
