

  import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/profile_body_edit.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String email=box.read('email');
    String name=box.read('name');
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(locale.myProfile.toString()),
        textTheme:
        TextTheme(headline6: TextStyle(color: Colors.black, fontSize: 16)),
      ),
      body: BodyEdit(
        name: name,
        email: email,
      ),
    );
  }
}