import 'package:flutter/material.dart';
import 'package:ungweight/utility/my_constant.dart';

class ShowButton extends StatelessWidget {
  final double? width;
  final String label;
  final Function() pressFunc;
  final Color? color;
  const ShowButton({
    Key? key,
    this.width,
    required this.label,
    required this.pressFunc,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: width ?? 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          primary: color ?? MyConstant.primary,
        ),
        onPressed: pressFunc,
        child: Text(label),
      ),
    );
  }
}
