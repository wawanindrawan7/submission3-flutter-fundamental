import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:submission_flutter/data/api/api_service.dart';
import 'package:submission_flutter/pages/favorite_page.dart';
import 'package:submission_flutter/pages/profile_page.dart';
import 'package:submission_flutter/pages/search_page.dart';
import 'package:submission_flutter/provider/restaurant_list_provider.dart';
import 'package:submission_flutter/style/style.dart';
import 'package:submission_flutter/utils/request_state.dart';
import 'package:submission_flutter/widgets/card_restaurant.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget _buildList() {
      return ChangeNotifierProvider(
        create: (_) => RestaurantListProvider(
          apiService: ApiService(Client()),
        ),
        child: Consumer<RestaurantListProvider>(
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
              return _buildBody(context, state);
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
      );
    }

    return Scaffold(
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Favorite();
          }));
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.favorite),
      ),
    );
  }

  SafeArea _buildBody(BuildContext context, RestaurantListProvider state) {
    return SafeArea(
      child: ListView(
        children: [
          Hero(
            tag: Text(
              'Dicoding Restaurant',
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageProfile(),
                      Text(
                        'Dicoding Restaurant',
                        style: hometext.copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            SearchPage.routeName,
                          );
                        },
                        icon: Icon(
                          Icons.search,
                          color: kNightBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: state.result!.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result!.restaurants[index];
              return CardListRestaurant(restaurant: restaurant);
            },
          )
        ],
      ),
    );
  }
}

class ImageProfile extends StatelessWidget {
  const ImageProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProfilePage.routeName,
        );
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xff7c94b6),
          image: DecorationImage(
            image: AssetImage('images/profile.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          border: Border.all(
            color: Colors.white,
            width: 4.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 4,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
