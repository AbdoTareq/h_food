import 'package:elm_task/core/error/exceptions.dart';
import 'package:elm_task/core/network/endpoints.dart';
import 'package:elm_task/core/network/network.dart';
import 'package:elm_task/export.dart';
import 'package:elm_task/features/products/data/models/products_wrapper.dart';

abstract class ProductsRemoteDataSource {
  Future<ProductsWrapper> getAllMeet();
  Future<ProductsWrapper> getAllCarbs();
  Future<ProductsWrapper> getAllVegetables();
  Future<Map<String, dynamic>> makeOrder(Map<String, dynamic> data);
}

class ProductsRemoteDataSourceImp implements ProductsRemoteDataSource {
  final NetworkInterface network;

  ProductsRemoteDataSourceImp({required this.network});

  @override
  Future<ProductsWrapper> getAllMeet() async {
    // final response = await network.get(Endpoints.meet, {});
    // if (response.statusCode == 200) {
    //   return ProductsWrapper.fromJson(response.data);
    // } else
    return ProductsWrapper.fromJson({
      "data": [
        {
          "food_name": "Chicken Breast",
          "calories": 165,
          "image_url":
              "https://www.savorynothings.com/wp-content/uploads/2021/02/airy-fryer-chicken-breast-image-8.jpg"
        },
        {
          "food_name": "Salmon",
          "calories": 206,
          "image_url":
              "https://cdn.apartmenttherapy.info/image/upload/f_jpg,q_auto:eco,c_fill,g_auto,w_1500,ar_1:1/k%2F2023-04-baked-salmon-how-to%2Fbaked-salmon-step6-4792"
        },
        {
          "food_name": "Lean Beef",
          "calories": 250,
          "image_url":
              "https://www.mashed.com/img/gallery/the-truth-about-lean-beef/l-intro-1621886574.jpg"
        },
        {
          "food_name": "Turkey",
          "calories": 135,
          "image_url":
              "https://fox59.com/wp-content/uploads/sites/21/2022/11/white-meat.jpg?w=2560&h=1440&crop=1"
        }
      ]
    });
  }

  @override
  Future<ProductsWrapper> getAllCarbs() async {
    // final response = await network.get(Endpoints.carbs, {});
    // if (response.statusCode == 200) {
    //   return ProductsWrapper.fromJson(response.data);
    // } else
    return ProductsWrapper.fromJson({
      "data": [
        {
          "food_name": "Brown Rice",
          "calories": 111,
          "image_url":
              "https://assets-jpcust.jwpsrv.com/thumbnails/k98gi2ri-720.jpg"
        },
        {
          "food_name": "Oats",
          "calories": 389,
          "image_url":
              "https://media.post.rvohealth.io/wp-content/uploads/2020/03/oats-oatmeal-732x549-thumbnail.jpg"
        },
        {
          "food_name": "Sweet Corn",
          "calories": 86,
          "image_url":
              "https://m.media-amazon.com/images/I/41F62-VbHSL._AC_UF1000,1000_QL80_.jpg"
        },
        {
          "food_name": "Black Beans",
          "calories": 132,
          "image_url":
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwxSM9Ib-aDXTUIATZlRPQ6qABkkJ0sJwDmA&usqp=CAU"
        }
      ]
    });
  }

  @override
  Future<ProductsWrapper> getAllVegetables() async {
    // final response = await network.get(Endpoints.vegetables, {});
    // if (response.statusCode == 200) {
    //   return ProductsWrapper.fromJson(response.data);
    // } else
    return ProductsWrapper.fromJson({
      "data": [
        {
          "food_name": "Broccoli",
          "calories": 55,
          "image_url":
              "https://cdn.britannica.com/25/78225-050-1781F6B7/broccoli-florets.jpg"
        },
        {
          "food_name": "Spinach",
          "calories": 23,
          "image_url":
              "https://www.daysoftheyear.com/cdn-cgi/image/dpr=1%2Cf=auto%2Cfit=cover%2Cheight=650%2Cq=40%2Csharpen=1%2Cwidth=956/wp-content/uploads/fresh-spinach-day.jpg"
        },
        {
          "food_name": "Carrot",
          "calories": 41,
          "image_url":
              "https://cdn11.bigcommerce.com/s-kc25pb94dz/images/stencil/1280x1280/products/271/762/Carrot__40927.1634584458.jpg?c=2"
        },
        {
          "food_name": "Bell Pepper",
          "calories": 31,
          "image_url":
              "https://i5.walmartimages.com/asr/5d3ca3f5-69fa-436a-8a73-ac05713d3c2c.7b334b05a184b1eafbda57c08c6b8ccf.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF"
        }
      ]
    });
  }

  @override
  Future<Map<String, dynamic>> makeOrder(Map<String, dynamic> data) async {
    final response = await network.get(Endpoints.vegetables, {});
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw ServerException(message: "Error");
    }
  }
}
