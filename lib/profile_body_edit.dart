

  import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
  import 'package:another_flushbar/flushbar.dart';
import 'Theme/colors.dart';

class BodyEdit extends StatelessWidget {
  String name, email;
  BodyEdit({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height:20
                ),
                Text(
                 locale.profileDetails.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 20,
                ),
                MenuForm(
                  name: name,
                  email: email,
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuForm extends StatefulWidget {
  String name, email;

  MenuForm({required this.name, required this.email});

  @override
  State<MenuForm> createState() => _MenuFormState();
}

class _MenuFormState extends State<MenuForm> {
  final List<String> errors = [];
  TextEditingController password = TextEditingController();
  TextEditingController password_check = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Form(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText:  locale.email,
              enabled: false,
              hintText: widget.email ?? "",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 42,
                vertical: 20,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color:primaryColor),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: primaryColor),
                gapPadding: 10,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            locale.changepassword.toString(),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height:20,
          ),
          TextFormField(
            controller: password,
            obscureText: true,
            decoration: InputDecoration(
              hintText: locale.enternewpassword,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 42,
                vertical: 20,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: primaryColor),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: primaryColor),
                gapPadding: 10,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: password_check,
            obscureText: true,
            decoration: InputDecoration(
              hintText: locale.confirmpassword,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 42,
                vertical: 20,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color:primaryColor),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color:primaryColor),
                gapPadding: 10,
              ),
            ),
          ),
          ////////////////////
          SizedBox(
            height:50,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: 56,
              width: double.infinity,
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: primaryColor,
                  onPressed: () async {
                    if (password_check.text.toString() !=
                        password.text.toString()) {
                      await Flushbar(
                          title: 'Wrong ',
                          message:
                          ' password didnot match',
                          duration: Duration(seconds: 3),
                    ).show(context);

                    } else {
                      changePawword();
                    //  Get.off(MainPage());
                    }
                  },
                  child: Text(
                    locale.changepassword.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  changePawword() async {
    User? user = FirebaseAuth.instance.currentUser;
    print("user" + user.toString());
    await user!.updatePassword(password.text.toString());

    await Flushbar(
      title: 'DONE',
      message:
      'Password changed Successfully',
      duration: Duration(seconds: 3),
    ).show(context);

  }
}