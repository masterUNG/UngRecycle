// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungweight/utility/my_constant.dart';
import 'package:ungweight/widgets/show_logo.dart';
import 'package:ungweight/widgets/show_text.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> normalDialog(
      {required String title, required String message}) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: const SizedBox(width: 60,
            child: ShowLogo(),
          ),
          title: ShowText(
            text: title,
            textStyle: MyConstant().h2Style(),
          ),subtitle: ShowText(text: message),
        ),actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
      ),
    );
  }
}
