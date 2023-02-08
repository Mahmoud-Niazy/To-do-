import 'package:flutter/material.dart';

Widget BuildTextFormField(
{
  required TextEditingController controller,
  required String label,
  required IconData prefix_icon,
  required String? Function(String?)? validate,
  IconData? suffix_icon,
  Function(String)? submit ,
  bool is_password = false,
 void Function()? on_pressed_on_suffix,
  void Function()? on_tap ,

}
    ){
  return  TextFormField(
    onTap: on_tap,
    controller: controller ,
    decoration: InputDecoration(
      label: Text(
        label,
      ),
      border: OutlineInputBorder(),

      prefixIcon: Icon(
        prefix_icon,
      ),
      suffixIcon: IconButton(
        icon: Icon(
          suffix_icon,
        ),
        onPressed: on_pressed_on_suffix ,
      ),
    ),
    validator: validate,
    onFieldSubmitted: submit ,
    obscureText: is_password,
  );
}

Widget BuildMaterialButton({
  Color color = Colors.blue,
  double height = 40.0,
  double width =double.infinity,
  required Function()? on_pressed,
  required String label,
  bool is_upper_case = false,
}){
  return  Container(
    color:color ,
    height: height,
    width: width,
    child: MaterialButton(
      onPressed:on_pressed,
      child: Text(
       is_upper_case? label.toUpperCase() : label ,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        ),
      ),
    );

}