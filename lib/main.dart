

import 'package:admob_inline_ads_in_flutter/destination.dart';
import 'package:admob_inline_ads_in_flutter/banner_inline_page.dart';
import 'package:admob_inline_ads_in_flutter/home_page.dart';
import 'package:admob_inline_ads_in_flutter/native_inline_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder>{
        '/banner': (context) =>
            BannerInlinePage(entries: Destination.samples),
        '/native': (context) =>
            NativeInlinePage(entries: Destination.samples),
      },
      home: HomePage(),
    );
  }
}
