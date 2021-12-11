import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:submission_flutter/data/model/restaurant_detail.dart';
import 'package:submission_flutter/style/style.dart';

class ReviewsCustomer extends StatelessWidget {
  const ReviewsCustomer({Key? key, required this.restaurant}) : super(key: key);
  final Restaurant restaurant;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: kGreyColor,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Center(
          child: Row(
            children: [
              Icon(Icons.people_alt_sharp),
              SizedBox(
                width: 5,
              ),
              Text('Customer Reviews'),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: restaurant.customerReviews.map(
                (review) {
                  return FadeInUp(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: kNightBlackColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/review.png",
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review.name,
                                  style: titleTextStyle.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  review.date,
                                  style: customerReview.copyWith(
                                      fontSize: 10, color: date),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 50,
                                  width: 150,
                                  child: Text(
                                    review.review,
                                    style:
                                        customerReview.copyWith(fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
