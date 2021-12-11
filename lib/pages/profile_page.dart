import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_flutter/provider/preferences_provider.dart';
import 'package:submission_flutter/provider/scedule_provider.dart';
import 'package:submission_flutter/style/style.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return Consumer<ScheduleProvider>(
          builder: (context, scheduled, _) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                ),
                              ),
                              Text(
                                'Profile',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.segment_sharp,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        FadeInUp(
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: const Color(0xff7c94b6),
                              image: DecorationImage(
                                image: AssetImage('images/profile.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100.0)),
                              border: Border.all(
                                width: 4.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Column(
                          children: [
                            Text(
                              'Muhamad Wawan Indrawan',
                            ),
                            Text(
                              '(Owener)',
                            ),
                          ],
                        ),
                        Align(
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Divider(
                              height: 20,
                              thickness: 4,
                              indent: 10,
                              endIndent: 10,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ProfileActivity(
                                number: '400',
                                text: 'Order',
                              ),
                              ProfileActivity(
                                number: '400',
                                text: 'Transaction',
                              ),
                              ProfileActivity(
                                number: '5',
                                text: 'Report',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Column(
                            children: [
                              ProfileWidget(
                                text: 'Setting',
                                icon: Icons.settings,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ProfileWidget(
                                text: 'Transaction',
                                icon: Icons.price_change,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ProfileWidget(
                                text: 'User Managment',
                                icon: Icons.person,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ProfileWidget(
                                text: 'Report Transaction',
                                icon: Icons.report,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.only(top: 20, bottom: 10),
                                  child: Divider(
                                    thickness: 4,
                                    indent: 5,
                                    endIndent: 5,
                                  ),
                                ),
                              ),
                              ProfileWidget(
                                text: 'Information',
                                icon: Icons.perm_device_information,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              ProfileWidget(
                                text: 'Log Out',
                                icon: Icons.logout_outlined,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.alarm,
                              ),
                              Text(
                                'Scheduling Restaurant',
                              ),
                              Switch.adaptive(
                                activeColor: kSecondaryColor,
                                value: provider.isDailyRestoActive,
                                onChanged: (value) async {
                                  scheduled.scheduledResto(value);
                                  provider.enableDailyResto(value);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}

class ProfileActivity extends StatelessWidget {
  const ProfileActivity({
    Key? key,
    required this.number,
    required this.text,
  }) : super(key: key);

  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
        ),
        Text(
          text,
        ),
      ],
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key, required this.icon, required this.text})
      : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon),
        Text(text),
        Icon(
          Icons.keyboard_arrow_right,
        ),
      ],
    );
  }
}
