import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:doctoworld_doctor/Auth/Registration/UI/registration_ui.dart';
import 'package:doctoworld_doctor/BottomNavigation/bottom_navigation.dart';
// import 'package:buy_this_app/buy_this_app.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/view_model/auth_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Config/app_config.dart';
import 'login_interactor.dart';

class LoginUI extends StatefulWidget {
  final LoginInteractor loginInteractor;

  LoginUI(this.loginInteractor);

  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final TextEditingController _EmailController = TextEditingController();
  final TextEditingController _PassController = TextEditingController();

  @override
  void dispose() {
    _EmailController.dispose();
    _PassController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _checkForBuyNow();

  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.primaryColorLight,
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            // height: size.height + 40,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: size.height * 0.6,
                  color: theme.backgroundColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Spacer(),
                      Expanded(
                          flex: 2,
                          child: Image.asset('assets/icons/doctor_logo.png')),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Doctor App',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Theme.of(context).primaryColor, fontSize: 14),
                      ),
                      Spacer(),
                      Expanded(
                          flex: 4, child: Image.asset('assets/hero_image.png')),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: GetBuilder<AuthViewModel>(
                      init: AuthViewModel(),
                      builder: (controller) =>
                     Column(
                      children: [
                        SizedBox(height: size.height * 0.52),
                        EntryField(
                          hint: locale.enterEmail,
                          prefixIcon: Icons.phone_iphone,
                          color: theme.scaffoldBackgroundColor,
                          controller: _EmailController,
                        ),
                        SizedBox(height: 20.0),
                        EntryField(
                          hint: locale.enterPassword,
                          prefixIcon: Icons.phone_iphone,
                          color: theme.scaffoldBackgroundColor,
                          controller: _PassController,
                        ),
                        SizedBox(height: 15.0),

                        Container(
                        width: 260,
                          height:50,
                          child: RaisedButton(
                              color:  theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(locale.login.toString(),style:TextStyle(
                                color:Colors.white,fontSize:21
                              )),
                              onPressed:()async {
                                FirebaseAuth _auth = FirebaseAuth.instance;

                                print("ppp");
                                try {
                                  await _auth
                                      .signInWithEmailAndPassword
                                    (email: _EmailController.text,
                                      password: _PassController.text)
                                      .then((value) async {
                                    print("vvvv");
                                    final box = GetStorage();
                                    box.write('email', _EmailController.text);
                                    box.write('pass', _PassController.text);
                                    box.write('name', 'User');
                                    print("xsxx");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          BottomNavigation()),
                                    );

                                    // controller.signInWithEmailAndPassword
                                    //   (_EmailController.text, _PassController.text);
                                    //  Get.to(BottomNavigation());
                                  });
                                }catch (e) {
                                  await Flushbar(
                                    title: 'Error',
                                    message:
                                    e.toString(),
                                    duration: Duration(seconds: 3),
                                  ).show(context);

                                }
                              }  )
                        ),
                        // CustomButton(
                        //   onTap:(){
                        //     print("ppp");
                        //     controller.signInWithEmailAndPassword
                        //       (_EmailController.text, _PassController.text);
                        //   }
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Or",style:TextStyle(
                          color:Colors.red,fontSize:23
                        ),),
                        SizedBox(height: 10,),
                        InkWell(

                          child: Text(locale.signup.toString(),
                          style:TextStyle(
                            color:theme.primaryColor,
                          ),
                          ), onTap:(){

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                RegistrationUI()),
                          );

                          },
                        )


                        // Text(
                        //   locale.orQuickContinueWith!,
                        //   style: theme.textTheme.subtitle1,
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Container(
                        //         decoration: BoxDecoration(
                        //           color: Color(0xff3c5a9a),
                        //           borderRadius: BorderRadius.circular(8),
                        //         ),
                        //         padding: EdgeInsets.all(16.0),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             Image.asset('assets/icons/ic_fb.png',
                        //                 scale: 2),
                        //             SizedBox(width: 20),
                        //             Expanded(
                        //               child: Text(
                        //                 locale.facebook!,
                        //                 textAlign: TextAlign.center,
                        //                 overflow: TextOverflow.ellipsis,
                        //                 style: Theme.of(context)
                        //                     .textTheme
                        //                     .subtitle1!
                        //                     .copyWith(
                        //                         color: Colors.white,
                        //                         fontSize: 15),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(width: 20.0),
                        //     Expanded(
                        //       child: CustomButton(
                        //         label: locale.gmail,
                        //         icon: Image.asset(
                        //           'assets/icons/ic_ggl.png',
                        //           scale: 3,
                        //         ),
                        //         color: theme.scaffoldBackgroundColor,
                        //         textColor: theme.hintColor,
                        //         onTap: () =>
                        //             widget.loginInteractor.loginWithGoogle(),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  void _checkForBuyNow() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // if (!sharedPreferences.containsKey("key_buy_this_shown") &&
    //     AppConfig.isDemoMode) {
    //   Future.delayed(Duration(seconds: 10), () async {
    //     if (mounted) {
    //       BuyThisApp.showSubscribeDialog(context);
    //       sharedPreferences.setBool("key_buy_this_shown", true);
    //     }
    //   });
    // }
  }
}
