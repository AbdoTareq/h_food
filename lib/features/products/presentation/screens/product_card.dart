import 'package:h_food/core/view/widgets/my_list_tile.dart';
import 'package:h_food/core/view/widgets/old_fade_image.dart';
import 'package:h_food/export.dart';
import 'package:h_food/features/products/domain/entities/products.dart';
import 'package:h_food/features/products/presentation/bloc/products_bloc.dart';
import 'package:h_food/features/products/presentation/bloc/products_event.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: kWhite,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: .45.sw - 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: .45.sw - 16,
                height: 90,
                child: FadeImage(imagePath: product.imageUrl),
              ),
              8.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.foodName),
                  Text(
                    '${product.calories} ${context.t.cal}',
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$12'),
                  RoundedCornerButton(
                    width: 70,
                    height: 32,
                    onPressed: () {
                      sl<ProductsBloc>().add(AddToCart(product));
                    },
                    text: context.t.add,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
