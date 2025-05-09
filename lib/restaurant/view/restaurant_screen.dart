import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:medium_actual/common/const/data.dart';
import 'package:medium_actual/restaurant/component/restaurant_card.dart';
import 'package:medium_actual/restaurant/model/restaurant_model.dart';
import 'package:medium_actual/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<Map<String, dynamic>> paginateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.get(
      'http://$ip/restaurant',
      options: Options(headers: {'authorization': 'Bearer $accessToken'}),
    );

    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: FutureBuilder<Map<String, dynamic>>(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<Map> snapshot) {
              print(snapshot.error);
              print(snapshot.data);
              if (!snapshot.hasData) {
                return Container();
              }

              return ListView.separated(
                itemCount: snapshot.data!['data'].length,
                itemBuilder: (_, index) {
                  final item = snapshot.data!['data'][index];
                  final pItem2 = RestaurantModel.fromJson(json: item);

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (_) => RestaurantDetailScreen(id: pItem2.id),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 20,
                        ),
                        child: RestaurantCard.fromModel(model: pItem2),
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, index) {
                  return SizedBox(height: 16);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
