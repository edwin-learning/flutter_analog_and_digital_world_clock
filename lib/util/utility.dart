import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'shared_preferences_utils.dart';
import 'time_zone_utils.dart';

enum Choice { WorldTime, CurrentTime }

String locationName = 'Asia/Shanghai';
DateTime currentTime = DateTime.now();

Future<String> getLocationFromSharedPref() async {
  final lastUsedLocation = SpUtils.getString('Location');
  return lastUsedLocation ?? 'Asia/Shanghai';
}

Future<void> setLocationPref(String location) async {
  SpUtils.setString('Location', location);
}

getFormatedTime() {
  return DateFormat("hh:mm a").format(currentTime);
}

const int purple = 0xff3c1361;
const int red = 0xffff2525;
const int brightYellow = 0xffffe03d;
const int midYellow = 0xffffd03d;
const int yellow = 0xffffc03d;
const int silver = 0xfff2f5fc;
const int darkSilver = 0xffe7eefb;

const kTopRowTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'Varela',
  color: Color(purple),
);

const kSelectedTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'Varela',
  color: Color(midYellow),
);

const kTimeTextStyle = TextStyle(
  fontSize: 56.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'Varela',
  color: Color(purple),
);
