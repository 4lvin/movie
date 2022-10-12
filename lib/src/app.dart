import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/src/router/constant.dart';
import 'package:movies/src/router/router.dart' as RouterGen;
import 'package:movies/src/router/router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: rootRoute,
      getPages: routes,
    );
  }
}
