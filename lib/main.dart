import 'package:flutter/material.dart';
import 'package:car_pair_links/home.dart';
import 'package:car_pair_links/roomHome.dart';
import 'package:car_pair_links/roomCreate.dart';
import 'package:car_pair_links/roomEnter.dart';
import 'package:car_pair_links/room Public.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/roomHome': (context) => RoomeHome(),
      '/roomCreate': (context) => RoomeCreate(),
      '/roomEnter': (context) => RoomeEnter(),
      '/room/public': (context) => RoomePublic(),
      // '/room/private': (context) => RoomeHome(),
    },
  ));
}
