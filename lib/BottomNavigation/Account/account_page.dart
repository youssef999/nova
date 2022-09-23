import 'dart:io';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Auth/login_navigator.dart';
import 'package:doctoworld_doctor/BottomNavigation/Account/change_language_page.dart';
import 'package:doctoworld_doctor/BottomNavigation/Account/support_page.dart';
// import 'package:buy_this_app/buy_this_app.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/Routes/routes.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/edit_image.dart';
import 'package:doctoworld_doctor/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import '../../Config/app_config.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class MenuTile {
  String? title;
  String? subtitle;
  IconData iconData;
  Function onTap;
  MenuTile(this.title, this.subtitle, this.iconData, this.onTap);
}

class _AccountPageState extends State<AccountPage> {
  File ? _image ;
  @override
  Widget build(BuildContext context)
  {
    var locale = AppLocalizations.of(context)!;
    final box = GetStorage();
    String name=box.read('name')??"";
    String phone=box.read('phone')??"";

    List<MenuTile> _menu = [

      MenuTile(locale.myProfile, locale.setUpProfile, Icons.store, () {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditProfile()),
        );

     //   Navigator.pushNamed(context, PageRoutes.profilePage);
      }),
      MenuTile(locale.language, locale.changeLanguage, Icons.language, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChangeLanguagePage()),
        );
        //Navigator.pushNamed(context, PageRoutes.languagePage);
      }),
      MenuTile(locale.contactUs, locale.letUsHelpYou, Icons.mail, () {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>SupportPage()),
        );
       // Navigator.pushNamed(context, PageRoutes.supportPage);
      }),
      // MenuTile(locale.tnC, locale.policies, Icons.assignment, () {
      //   Navigator.pushNamed(context, PageRoutes.tncPage);
      // }),
      // MenuTile(locale.faqs, locale.quickAnswers, Icons.announcement, () {
      //   Navigator.pushNamed(context, PageRoutes.faqPage);
      // }),
      MenuTile(locale.logout, locale.seeYouSoon, Icons.exit_to_app, () {

        // final box = GetStorage();
        // box.remove('email');
        // box.remove('name');
        // print("removed");
     //   FirebaseAuth.instance.signOut().then((value) =>
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>ChangeLanguagePage()),
          );
       //);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => LoginNavigator()),
        // );
      }),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          locale.account!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              children: [
                Row(
                  children: [

                    SizedBox(
                      width: 5,
                    ),
                    // GestureDetector(
                    //     child: Icon(Icons.add_photo_alternate,
                    //         size:35, color: Colors.red),
                    //     onTap: pickImage),


                    SizedBox(
                      width: 4,
                    ),

                    // InkWell(
                    //   child: Container(
                    //     height:120,
                    //     child: Card(
                    //       color:primaryColor,
                    //       child:Text("Change Profile",
                    //       style:TextStyle(
                    //         color:Colors.white,
                    //         fontSize:21
                    //       ),
                    //       ),
                    //     ),
                    //   ),
                    //   onTap:(){
                    //     Get.to(EditImage());
                    //   },
                    // )
                    // CircleAvatar(
                    //   backgroundColor: Colors.red,
                    //   backgroundImage:
                    //   _image == null ? null : FileImage(_image!),
                    //   radius: 50,
                    // ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    // GestureDetector(
                    //   child: Icon(Icons.clear, size: 40, color: Colors.red),
                    //   onTap: clear,
                    // ),
                  ],
                ),

                // FadedScaleAnimation(
                //   Image.asset(
                //     'assets/doc1.png',
                //     width: MediaQuery.of(context).size.width / 2.5,
                //   ),
                //   durationInMilliseconds: 400,
                // ),
                SizedBox(width: 16),
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: name+'\n' + '\n',
                      style: Theme.of(context).textTheme.headline5),
                  TextSpan(
                      text: phone,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: lightGreyColor)),
                ]))
              ],
            ),
          ),

          Container(
            color: Theme.of(context).primaryColorLight,
            child: GridView.builder(
                itemCount: _menu.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.6,
                    crossAxisCount: 2,
                    mainAxisExtent: 102),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: _menu[index].onTap as void Function()?,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadedScaleAnimation(
                            Text(
                              _menu[index].title!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            durationInMilliseconds: 400,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _menu[index].subtitle!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          fontSize: 12, color: lightGreyColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(
                                _menu[index].iconData,
                                size: 32,
                                color: Theme.of(context).primaryColorLight,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          // AppConfig.isDemoMode
          //     ? Container(
          //         padding: const EdgeInsets.all(8),
          //         child: BuyThisApp.developerRowOpus(
          //             Colors.transparent, Theme.of(context).primaryColor),
          //       )
          //     : const SizedBox.shrink(),
        ],
      ),
      // floatingActionButton: AppConfig.isDemoMode
      //     ? BuyThisApp.button(
      //         AppConfig.appName,
      //         'https://dashboard.vtlabs.dev/projects/envato-referral-buy-link?project_slug=doctoworld_flutter',
      //       )
      //     : null,
    );
  }
 //  Future pickImage() async {
 //  //  final ImagePicker _picker = ImagePicker;
 // File image = await ImagePicker().getImage(source: ImageSource.gallery);
 //    //pickImage(source: ImageSource.gallery)) ;
 //
 //
 //    // CroppedFile? file=await  ImageCropper().cropImage(
 //    //     sourcePath: image!.path,aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
 //
 //
 //    //ImageCropper.cropImage(sourcePath:image.path,aspectRatio:CropAspectRatio(ratioX: 1, ratioY: 1));
 //
 //    //set state bt3ml update kol shwya
 //
 //    setState(() {
 //      _image = image   ; //file as File? ;
 //    });
 //
 //  }


  Future clear() async{
    setState(() {
      _image = null;
    });
  }

}
