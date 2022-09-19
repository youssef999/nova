

import 'package:flutter/material.dart';


import 'custom_text.dart';

class CustomButton extends StatelessWidget {

  final String  text;
  final Function  onPressed;

  const CustomButton({
    required this.text,
    required this.onPressed
  });


   @override
   Widget build(BuildContext context) {
     return  FlatButton(
         shape:RoundedRectangleBorder(
           borderRadius:BorderRadius.circular(20),

         ),
         padding:EdgeInsets.all(18),
         color: Colors.blue,
         onPressed:onPressed(),
         child:Custom_Text(
           text:text,
           fontSize:18,
           alignment:Alignment.center,
           color: Colors.white,
         ));
   }
 }
