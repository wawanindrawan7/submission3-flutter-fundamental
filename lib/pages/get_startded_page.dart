import 'package:flutter/material.dart';
import 'package:submission_flutter/pages/home_page.dart';


class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0XFFC4C4C4),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 230,
            child: Image.asset('images/get_started.png'),
          ),
          Container(
            child: Text(
              'Dicoding Restaurant',
              style: TextStyle(
                  color: Color(0XFF426FB4),
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          Container(
            height: 69,
            width: 303,
            child: Text(
              'No need to worry about how hard for you to search a job. Start it now.',
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HomePage();
              }));
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: Text("Let's Eat"),
          )
        ],
      )),
    );
  }
}
