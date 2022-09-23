import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctoworld_doctor/BottomNavigation/bottom_navigation.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final TextEditingController _EmailController = TextEditingController();
    final TextEditingController _MsgController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        title: Text(
          locale.support!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.vertical,
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  locale.howMayWeHelpYou!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12.0),
                Text(
                  locale.letUsKnowUrQueriesFeedbacks!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Color(0xff7c7c7c)),
                ),
                Spacer(),

                EntryField(
                    controller:_EmailController,
                    prefixIcon: Icons.mail, hint: locale.emailAddress),
                SizedBox(height: 12.0),
                TextFormField(
                  maxLines: 4,
                  controller:_MsgController,
                  decoration: InputDecoration(
                      prefixIcon: Container(
                        transform: Matrix4.translationValues(0, -30, 0),
                        child: Icon(
                          Icons.edit,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      hintText: locale.writeYourMsg,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: textFieldColor, fontSize: 15),
                      filled: true,
                      fillColor: Theme.of(context).primaryColorLight,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      )),
                ),
                Spacer(),
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

    await FirebaseFirestore.instance.collection('support').add({
    'email': _EmailController.text,
    'message': _MsgController.text,
    }).then((value) async {
      await Flushbar(
          title: 'Done',
          message:
          locale.requestsent.toString(),
      duration: Duration(seconds: 3),
      ).show(context);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigation()),
      );
    });
    },
                        child: Text(
                          locale.send.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              //  CustomButton(label: locale.submit),
                Spacer(),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: FadedScaleAnimation(
                      Image.asset('assets/hero_image.png'),
                      durationInMilliseconds: 400,
                    ),
                  ),
                )
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
}
