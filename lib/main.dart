import 'package:flutter/material.dart';

import 'page/home.dart';
import 'util/shared_preferences_utils.dart';
import 'util/time_zone_utils.dart';

void main() {
  realRunApp();
}

void realRunApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtils.init();
  await TimeZoneUtils.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
