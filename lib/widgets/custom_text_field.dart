// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:waether_forecast_app/utils/txt_style.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
  final bool obsecureText;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final bool readOnly;

  CustomTextField(
    {
      Key? key,
      required this.controller,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.onTap,
      this.obsecureText = false,
      this.validator,
      this.textInputType,
      this.readOnly = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // ignore: prefer_const_literals_to_create_immutables
        // boxShadow: [
        //   BoxShadow(
        //     blurRadius: 3,
        //     color: Colors.black,
        //     offset: Offset(1,3),
        //   )
        // ]
      ),
      child: TextFormField(
      
        style: TxtStyle.headLineStyle3,
      
        controller: widget.controller,
        // cursorColor: Colors.white,
        keyboardType: widget.textInputType,
        obscureText: widget.obsecureText,
        validator: widget.validator,
      
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            // borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.black38, width: 0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          // filled: true,
          // fillColor: Colors.teal,
          hintText: widget.hintText,
          hintStyle: TxtStyle.headLineStyle3,
          prefixIcon: Icon(widget.prefixIcon, color: Colors.black38),
          suffixIcon: InkWell(
            onTap: widget.onTap,
            child: Icon(widget.suffixIcon, color: Colors.black38),
          ),
        ),
        readOnly: widget.readOnly,
      ),
    );
  }
}