import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_flutter/data/model/restaurant_list.dart';
import 'package:submission_flutter/pages/detail_page.dart';
import 'package:submission_flutter/provider/database_provider.dart';
import 'package:submission_flutter/style/style.dart';

class CardListRestaurant extends StatefulWidget {
  final Restaurants restaurant;

  const CardListRestaurant({required this.restaurant});

  @override
  State<CardListRestaurant> createState() => _CardListRestaurantState();
}

class _CardListRestaurantState extends State<CardListRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.isFavorited(widget.restaurant.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                    arguments: widget.restaurant.id);
              },
              child: FadeInUp(
                duration: Duration(milliseconds: 800),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10, top: 5),
                    decoration: BoxDecoration(
                      color: kNightBlackColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Hero(
                            tag: widget.restaurant.id,
                            child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "$IMAGE_BASE_URL${widget.restaurant.pictureId}",
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: Text(
                                  widget.restaurant.name,
                                  style: titleTextStyle.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.room,
                                    color: kSecondaryColor,
                                    size: 22,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    widget.restaurant.city,
                                    style: subtitleTextStyle.copyWith(
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  height: 30,
                                  width: 56,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Icon(
                                          Icons.star_rounded,
                                          color: star,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Expanded(
                                        child: Text(
                                          widget.restaurant.rating.toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: kSecondaryColor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                  ),
                                  child: isFavorited
                                      ? IconButton(
                                          onPressed: () =>
                                              provider.removeFavorite(
                                                  widget.restaurant.id),
                                          icon: Icon(Icons.favorite),
                                          color: Colors.red)
                                      : IconButton(
                                          icon: Icon(Icons.favorite_border),
                                          color: Colors.white,
                                          onPressed: () => provider
                                              .addFavorites(widget.restaurant),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    });
  }
}
