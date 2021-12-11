import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:submission_flutter/data/api/api_service.dart';
import 'package:submission_flutter/data/model/restaurant_detail.dart';
import 'package:submission_flutter/pages/reviews_page.dart';
import 'package:submission_flutter/provider/resturant_detail_provider.dart';
import 'package:submission_flutter/style/style.dart';
import 'package:submission_flutter/utils/request_state.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/detail_page';

  final String id;

  const RestaurantDetailPage({required this.id});

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  Widget contentBody(BuildContext context, Restaurant restaurant) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Hero(
              tag: restaurant.id,
              child: Container(
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "$IMAGE_BASE_URL${restaurant.pictureId}"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 320),
              child: Container(
                height: 1000,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 350, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: detail,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.room,
                        size: 30,
                        color: kSecondaryColor,
                      ),
                      SizedBox(width: 5),
                      Text(
                        restaurant.city,
                        style: detail,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        restaurant.rating,
                        style: detail,
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.star,
                        color: star,
                      ),
                      Icon(
                        Icons.star,
                        color: star,
                      ),
                      Icon(
                        Icons.star,
                        color: star,
                      ),
                      Icon(
                        Icons.star,
                        color: star,
                      ),
                      Icon(
                        Icons.star,
                        color: star,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    'Description',
                    style: detail,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FadeInUp(
                    child: Text(
                      restaurant.description,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Food',
                    style: detail,
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 800),
                    child: Column(
                      children: restaurant.menus.foods.map(
                        (foods) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: kSecondaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                    height: 5,
                                  ),
                                  Text(foods.name),
                                ],
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Drink',
                    style: detail,
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 800),
                    child: Column(
                      children: restaurant.menus.drinks.map(
                        (drink) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: kSecondaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                    height: 5,
                                  ),
                                  Text(drink.name),
                                ],
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 80,
                    width: 200,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kSecondaryColor),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ReviewsCustomer(restaurant: restaurant);
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Reviews Restaurant',
                        style: titleTextStyle.copyWith(fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: IconButton(
                      icon: Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Share.share(restaurant.description);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) => RestaurantDetailProvider(
            apiService: ApiService(Client()), id: widget.id),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == RequestState.Loading) {
              return Center(
                child: LottieBuilder.asset(
                  'assets/loading.json',
                  height: 330,
                  width: 400,
                ),
              );
            } else if (state.state == RequestState.HasData) {
              var restaurant = state.result!.restaurant;
              return Stack(
                children: [
                  contentBody(context, restaurant),
                ],
              );
            } else if (state.state == RequestState.NoData) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == RequestState.Error) {
              return Center(
                child: LottieBuilder.asset(
                  'assets/connection.json',
                  height: 330,
                  width: 400,
                ),
              );
            } else {
              return Center(
                child: Text(''),
              );
            }
          },
        ),
      ),
    );
  }
}
