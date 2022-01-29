import 'package:flutter/material.dart';

class MyConstant {
  static String appName = 'อึ่ง Recycle';

  static String rountAuthen = '/authen';
  static String rountMyService = '/myService';
  static String rountGetHospital = '/getHospital';


  static String domain = 'https://www.androidthai.in.th';

  static Color primary = const Color(0xff14491d);
  static Color dart = const Color(0xff002200);
  static Color light = const Color(0xff427545);

  BoxDecoration planBox() => BoxDecoration(
        color: light.withOpacity(0.6),
      );

  BoxDecoration gradianBox() => BoxDecoration(
        gradient: RadialGradient(
          radius: 1.0,
          colors: [Colors.white, primary],
        ),
      );

  TextStyle h1Style() => TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: dart,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: dart,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: dart,
      );
}
