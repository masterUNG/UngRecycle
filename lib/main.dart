import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungweight/states/authen.dart';
import 'package:ungweight/states/listview_get_hospital.dart';
import 'package:ungweight/states/my_service.dart';
import 'package:ungweight/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  MyConstant.rountAuthen: (BuildContext context) => const Authen(),
  MyConstant.rountMyService: (BuildContext context) => const MyService(),
  MyConstant.rountGetHospital: (BuildContext context) => const ListViewGetHospital(),
};

String? firstState;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverride();

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var result = preferences.getStringList('user');
  print('result ==> $result');

  if (result == null) {
    firstState = MyConstant.rountAuthen;
  runApp(const MyApp());
  } else {
    firstState = MyConstant.rountMyService;
  runApp(const MyApp());
  }

  
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: firstState,
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // TODO: implement createHttpClient
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
