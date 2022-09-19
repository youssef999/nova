import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctoworld_doctor/BottomNavigation/bottom_navigation.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/view_model/auth_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'registration_interactor.dart';

class RegistrationUI extends StatefulWidget {
  // final RegistrationInteractor registrationInteractor;
  // final String? phoneNumber;

 // RegistrationUI(this.registrationInteractor, this.phoneNumber);

  @override
  _RegistrationUIState createState() => _RegistrationUIState();
}

class _RegistrationUIState extends State<RegistrationUI> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        title: Text(locale.registerNow!,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        GetBuilder<AuthViewModel>(
            init: AuthViewModel(),
            builder: (controller) =>
           ListView(
            padding: EdgeInsets.all(20),
            children: [
              SizedBox(
                height: 3,
              ),
              // Text(
              //   locale.phoneNumberNotRegistered!,
              //   style: Theme.of(context).textTheme.bodyText1,
              //   textAlign: TextAlign.center,
              // ),
              SizedBox(
                height: 53,
              ),

              SizedBox(height: 20.0),
              EntryField(
                controller: _nameController,
                prefixIcon: Icons.person,
                hint: locale.fullName,
              ),
              SizedBox(height: 20.0),
              EntryField(
                controller: _emailController,
                prefixIcon: Icons.mail,
                hint: locale.emailAddress,
              ),
              SizedBox(height: 20.0),
              EntryField(
                controller: _passController,
                prefixIcon: Icons.password,
                hint:locale.enterPassword
              ),
              SizedBox(height: 20.0),
              // CustomButton(
              //   onTap: () => widget.registrationInteractor.register(
              //       widget.phoneNumber,
              //       _nameController.text,
              //       _emailController.text),
              // ),
              SizedBox(height: 10.0),
              // CustomButton(
              //   label: locale.backToSignIn,
              //   color: Theme.of(context).scaffoldBackgroundColor,
              //   textColor: Theme.of(context).hintColor,
              // //  onTap: widget.registrationInteractor.goBack,
              // ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 260,
                height:50,
                child: RaisedButton(
                    color:  theme.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(locale.signup.toString(),style:TextStyle(
                        color:Colors.white,fontSize:21
                    )),
                    onPressed:() async {
                      print("ppp");


                      final box = GetStorage();
                      FirebaseAuth _auth = FirebaseAuth.instance;
                      try {
                        await _auth
                            .createUserWithEmailAndPassword(email: _emailController.text,
                          password: _passController.text,  )
                            .then((user) async {
                          //saveUser(user);
                          final box1=box.write('email',_emailController.text);
                          final box2=box.write('pass',_passController.text);
                          final box3=box.write('name',_nameController.text);

                          await FirebaseFirestore.instance.collection('profiles').add({
                            'name': _nameController.text,
                            'email': _emailController.text,
                             'des':"",
                            'image':"http://pngimg.com/uploads/doctor/doctor_PNG16041.png",
                            'review':"",
                            'stars':2.1,
                            'time':"",
                            "day":"",
                            "comment":[]
                          });

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                BottomNavigation()),
                          );
                        });

                      } catch (e) {

                        await Flushbar(
                          title: 'Error',
                          message:
                          e.toString(),
                          duration: Duration(seconds: 3),
                        ).show(context);

                      }

                    }),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
