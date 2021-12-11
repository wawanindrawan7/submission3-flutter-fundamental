import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:submission_flutter/provider/restaurant_search_provider.dart';
import 'package:submission_flutter/utils/request_state.dart';
import 'package:submission_flutter/widgets/card_restaurant.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Widget _buildTextField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: Offset(0, 4),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: TextField(
        onSubmitted: (query) {
          Provider.of<RestaurantSearchProvider>(context, listen: false)
              .fecthRestaurantSearch(query);
        },
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 17),
          hintText: 'Search',
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),
      ),
    );
  }

  _buildSearchResult() {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, restaurant, child) {
        if (restaurant.state == RequestState.Loading) {
          return Center(
            child: LottieBuilder.asset(
              'assets/loading.json',
              height: 330,
              width: 400,
            ),
          );
        } else if (restaurant.state == RequestState.HasData) {
          if (restaurant.result!.restaurants.length == 0) {
            return Center(
              child: LottieBuilder.asset(
                'assets/trash.json',
                height: 330,
                width: 400,
              ),
            );
          } else {
            return Expanded(
              child: ListView.builder(
                itemCount: restaurant.result!.restaurants.length,
                itemBuilder: (context, index) {
                  return CardListRestaurant(
                      restaurant: restaurant.result!.restaurants[index]);
                },
              ),
            );
          }
        } else {
          return Center(
            child: Text(restaurant.message),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Restaurant'),
      ),
      body: Column(
        children: [
          _buildTextField(),
          SizedBox(
            height: 10,
          ),
          _buildSearchResult()
        ],
      ),
    );
  }
}
