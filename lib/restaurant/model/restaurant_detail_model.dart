import 'package:medium_actual/restaurant/model/restaurant_model.dart';

class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaruantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestaurantDetailModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: json['thumbUrl'],
      //간단한건 이렇게 바로 넣기
      tags: List<String>.from(json['tags']),
      //간단한건 이렇게 바로 넣기
      priceRange: RestaurantPriceRange.values.firstWhere(
        (e) => e.name == json['priceRange'],
      ),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      detail: json['detail'],
      //아래 중요
      products:
          json['products']
              .map<RestaruantProductModel>(
                (x) => RestaruantProductModel(
                  id: x['id'],
                  name: x['name'],
                  imgUrl: x['imgUrl'],
                  detail: x['detail'],
                  price: x['price'],
                ),
              )
              .toList(),
      //위 중요
    );
  }
}

class RestaruantProductModel {
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;

  RestaruantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  factory RestaruantProductModel.fromJson({
    required Map<dynamic, dynamic> json,
  }) {
    return RestaruantProductModel(
      id: json['id'],
      name: json['name'],
      imgUrl: json['imgUrl'],
      detail: json['detail'],
      price: json['price'],
    );
  }
}
