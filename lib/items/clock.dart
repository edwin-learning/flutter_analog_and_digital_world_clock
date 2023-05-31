import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../util/clock_painter.dart';
import '../util/time_zone_utils.dart';
import '../util/utility.dart';

class ClockView extends StatefulWidget {
  const ClockView({Key? key}) : super(key: key);

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    setInitialLocation();
    Timer.periodic(
        const Duration(seconds: 1),
        (Timer t) => setState(() {
              currentTime = TimeZoneUtils.getCurrentTime(locationName);
            }));
    super.initState();
  }

  setInitialLocation() async {
    locationName = await getLocationFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
          child: Text(
            getFormatedTime(),
            style: kTimeTextStyle,
          ),
        ),
      ),
      SizedBox(
        width: 320,
        height: 320,
        child: Stack(alignment: Alignment.center, children: [
          Container(
            constraints: const BoxConstraints.expand(),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color(0xffE3EDF7),
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                    colors: [Color(0xffecf6ff), Color(0xffcadbeb)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 32,
                    spreadRadius: 1,
                    offset: const Offset(30, 20),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    blurRadius: 32,
                    spreadRadius: 1,
                    offset: Offset(-20, -10),
                  ),
                ]),
          ),
          Container(
            width: 140,
            height: 140,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xffE3EDF7),
                gradient: const LinearGradient(
                    colors: [Color(0xffecf6ff), Color(0xffcadbeb)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 32,
                    spreadRadius: 1,
                    offset: const Offset(30, 20),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    blurRadius: 32,
                    spreadRadius: 1,
                    offset: Offset(-20, -10),
                  ),
                ]),
          ),
          Container(
            constraints: const BoxConstraints.expand(),
            child: Transform.rotate(
                angle: -pi / 2, child: CustomPaint(painter: ClockPainter())),
          ),
        ]),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
          child: Text(
            locationName,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Varela',
              color: Color(purple),
            ),
          ),
        ),
      ),
    ]);
  }
}
