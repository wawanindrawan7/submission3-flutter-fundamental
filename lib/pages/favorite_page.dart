import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:submission_flutter/provider/database_provider.dart';
import 'package:submission_flutter/style/style.dart';
import 'package:submission_flutter/utils/request_state.dart';
import 'package:submission_flutter/widgets/card_restaurant.dart';

class Favorite extends StatelessWidget {
  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == RequestState.HasData) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return CardListRestaurant(restaurant: provider.favorites[index]);
            },
          );
        } else {
          return Center(
            child: LottieBuilder.asset(
              'assets/trash.json',
              height: 330,
              width: 400,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Center(
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Text('Favorite Restaurant'),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 8),
        child: _buildList(),
      ),
    );
  }
}
