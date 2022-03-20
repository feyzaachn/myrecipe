import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidgets extends StatelessWidget{
  ValueChanged<String>? onChanged;
  FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final String labelText;
  final Widget prefixIcon;
  final bool obscureText;

  TextFormFieldWidgets({
    required this.onChanged,
    required this.validator,
    required this.keyboardType,
    required this.labelText,
    required this.prefixIcon,
    required this.obscureText,
});

  @override
  Widget build (BuildContext context){
    return TextFormField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      cursorColor: Colors.deepPurpleAccent,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          // text kutusuna tıklanmadan önce
            borderRadius: BorderRadius.circular(20),
            borderSide:
            const BorderSide(color: Colors.deepPurpleAccent)),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.deepPurpleAccent,
          fontSize: 15,
        ),
        prefixIcon: prefixIcon,
        focusedBorder: OutlineInputBorder(
          //Text kutusuna tıklandıktan sonra
            borderSide:
            const BorderSide(color: Colors.deepPurpleAccent),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
