import 'package:flutter/material.dart';
import 'package:ungweight/utility/my_constant.dart';
import 'package:ungweight/widgets/show_text.dart';

class ShowForm extends StatelessWidget {
  final double? width;
  final String label;
  final IconData iconData;
  final bool? obSecue;
  final Function(String) changeFunc;
  const ShowForm({
    Key? key,
    this.width,
    required this.label,
    required this.iconData,
    this.obSecue,
    required this.changeFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: width ?? 200,
      height: 40,
      child: TextFormField(onChanged: changeFunc,
        obscureText: obSecue ?? false,
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          prefixIcon: Icon(
            iconData,
            color: MyConstant.dart,
          ),
          label: ShowText(text: label),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.dart),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.light),
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
        ),
      ),
    );
  }
}
