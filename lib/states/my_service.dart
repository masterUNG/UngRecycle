import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungweight/utility/my_constant.dart';
import 'package:ungweight/widgets/show_button.dart';
import 'package:ungweight/widgets/show_logo.dart';
import 'package:ungweight/widgets/show_text.dart';

class MyService extends StatefulWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  String? dateTimeString;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setTime();
  }

  Future<void> setTime() async {
    DateTime dateTime = DateTime.now();
    DateFormat dateFormat = DateFormat('dd/MMM/yyyy HH:mm:ss');
    setState(() {
      dateTimeString = dateFormat.format(dateTime);
    });

    Duration duration = Duration(seconds: 1);
    await Timer(duration, () {
      setTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            newImage(),
            const ShowText(text: 'Server Date Time'),
            newDateTime(),
            newGetHospital(),
            newSignOut(),
          ],
        ),
      ),
    );
  }

  ShowButton newGetHospital() {
    return ShowButton(
      color: Colors.green,
      width: 250,
      label: 'รายการเก็บขยะมูลฝอย โรงพยาบาล',
      pressFunc: () => Navigator.pushNamed(context, MyConstant.rountGetHospital),
    );
  }

  ShowText newDateTime() => ShowText(
        text: dateTimeString!,
        textStyle: MyConstant().h2Style(),
      );

  SizedBox newImage() {
    return SizedBox(
      width: 250,
      child: ShowLogo(),
    );
  }

  ShowButton newSignOut() => ShowButton(
        color: Colors.red.shade900,
        label: 'Sign Out',
        pressFunc: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.clear().then(
                (value) => Navigator.pushNamedAndRemoveUntil(
                    context, MyConstant.rountAuthen, (route) => false),
              );
        },
      );
}
