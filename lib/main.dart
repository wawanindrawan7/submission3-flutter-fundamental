import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission_flutter/data/api/api_service.dart';
import 'package:submission_flutter/helpers/database_helper.dart';
import 'package:submission_flutter/helpers/preferences_helper.dart';
import 'package:submission_flutter/pages/detail_page.dart';
import 'package:submission_flutter/pages/home_page.dart';
import 'package:submission_flutter/pages/profile_page.dart';
import 'package:submission_flutter/pages/search_page.dart';
import 'package:submission_flutter/provider/database_provider.dart';
import 'package:submission_flutter/provider/preferences_provider.dart';
import 'package:submission_flutter/provider/restaurant_search_provider.dart';
import 'package:submission_flutter/provider/scedule_provider.dart';
import 'package:submission_flutter/services/background_services.dart';
import 'package:submission_flutter/splashscreen.dart';
import 'package:http/http.dart' as http;

import 'helpers/notifications_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantSearchProvider(
            apiService: ApiService(http.Client()),
          ),
        ),
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          HomePage.routeName: (context) => HomePage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                id: ModalRoute.of(context)!.settings.arguments as String,
              ),
          ProfilePage.routeName: (context) => ProfilePage(),
          SearchPage.routeName: (context) => SearchPage()
        },
      ),
    );
  }
}
