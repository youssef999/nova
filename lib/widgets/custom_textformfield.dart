

import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

import 'custom_text.dart';

class CustomTextFormField extends StatelessWidget {

  final String text;
  final String hint;
  final Function onSave;
  final bool obs ;
  final Function validator;
  final TextEditingController controller;
  final Color color;
  CustomTextFormField({required this.text,
    required  this.hint,
    required   this.onSave,
    required   this.obs,
    required  this.controller,
    required this.validator,
    required  this.color,
  }
      ) ;

  @override
  Widget build(BuildContext context) {
    return Container(
        child:  Column(
            children:[
              Custom_Text(
                  text:text,fontSize: 14,color:Colors.grey
              ),

              TextFormField(

                onSaved: onSave(),
                validator:validator() ,
                //    textDirection:TextDirection.rtl,
                obscureText:obs,
                controller: controller,
                // textAlign:TextAlign.end,

                decoration: InputDecoration(
                  hintText:hint,
                  hintStyle: TextStyle(color:Colors.grey),
                  fillColor:Colors.white,

                ),
              )
            ]
        )
    );
  }
}
