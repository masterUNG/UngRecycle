// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungweight/models/user_model.dart';
import 'package:ungweight/utility/my_constant.dart';
import 'package:ungweight/utility/my_dialog.dart';
import 'package:ungweight/widgets/show_button.dart';
import 'package:ungweight/widgets/show_form.dart';
import 'package:ungweight/widgets/show_logo.dart';
import 'package:ungweight/widgets/show_text.dart';

class Authen extends StatefulWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constrains) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Container(
            decoration: MyConstant().gradianBox(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  newLogo(constrains),
                  newAppName(),
                  newUser(constrains),
                  newPassword(constrains),
                  newButton(constrains),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  ShowButton newButton(BoxConstraints constrains) {
    return ShowButton(
      label: 'Login',
      width: constrains.maxWidth * 0.6,
      pressFunc: () {
        print('login with user = $user, password = $password');

        if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
          print('Have Space');
          MyDialog(context: context).normalDialog(
              title: 'Have Space ?', message: 'Please Fill Every Blank');
        } else {
          print('No Space');
          processCheckAuthen();
        }
      },
    );
  }

  ShowForm newPassword(BoxConstraints constrains) {
    return ShowForm(
      obSecue: true,
      label: 'Password :',
      iconData: Icons.lock_outline,
      width: constrains.maxWidth * 0.6,
      changeFunc: (String value) {
        password = value.trim();
      },
    );
  }

  ShowForm newUser(BoxConstraints constrains) {
    return ShowForm(
      width: constrains.maxWidth * 0.6,
      label: 'User :',
      iconData: Icons.person_outline,
      changeFunc: (String value) {
        user = value.trim();
      },
    );
  }

  ShowText newAppName() => ShowText(
        text: MyConstant.appName,
        textStyle: MyConstant().h1Style(),
      );

  SizedBox newLogo(BoxConstraints constrains) {
    return SizedBox(
      width: constrains.maxWidth * 0.6,
      child: const ShowLogo(),
    );
  }

  Future<void> processCheckAuthen() async {
    String path =
        '${MyConstant.domain}/bigc/getUserWhereUser.php?isAdd=true&user=$user';

    await Dio().get(path).then((value) async {
      print('value ==> $value');

      if (value.toString() == 'null') {
        MyDialog(context: context).normalDialog(
            title: 'User False ?', message: 'No $user in my Database');
      } else {
        for (var item in json.decode(value.data)) {
          print('item ==> $item');
          UserModel model = UserModel.fromMap(item);
          if (password == model.password) {
            print('Authen True');

            var data = <String>[];
            data.add(model.id);
            data.add(model.name);
            data.add(model.qrcode);
            data.add(model.address);

            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setStringList('user', data).then((value) {
              Navigator.pushNamedAndRemoveUntil(
                  context, MyConstant.rountMyService, (route) => false);
            });
          } else {
            MyDialog(context: context).normalDialog(
                title: 'Password False ?',
                message: 'Please Try Again Password False');
          }
        }
      }
    });
  }
}
