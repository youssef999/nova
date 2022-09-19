import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Auth/login_navigator.dart';
import 'package:doctoworld_doctor/BottomNavigation/bottom_navigation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../Components/custom_button.dart';
import '../../Config/app_config.dart';
import '../../Locale/language_cubit.dart';
import '../../Locale/locale.dart';
import '../../Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeLanguagePage extends StatefulWidget {
  final bool fromRoot;

  ChangeLanguagePage([this.fromRoot = true]);

  @override
  _ChangeLanguagePageState createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  late LanguageCubit _languageCubit;
  String? selectedLocal;

  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);

  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final box = GetStorage();
    String email=box.read('email')??"x";
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.changeLanguage!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            textTheme: Theme.of(context).textTheme,
          ),
          body: FadedSlideAnimation(
            Stack(
              children: [
                ListView(
                  children: [
                    BlocBuilder<LanguageCubit, Locale>(
                      builder: (context, currentLocale) {
                        selectedLocal ??= currentLocale.languageCode;
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: AppConfig.languagesSupported.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => RadioListTile(
                            value: AppConfig.languagesSupported.keys
                                .elementAt(index),
                            groupValue: selectedLocal,
                            title: Text(
                              AppConfig
                                  .languagesSupported[AppConfig
                                      .languagesSupported.keys
                                      .elementAt(index)]!
                                  .name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 15,
                                  ),
                            ),
                            onChanged: (langCode) => setState(
                                () => selectedLocal = langCode as String),
                          ),
                        );
                      },
                    ),

                    // RaisedButton(
                    //
                    //     onPressed:(){
                    //   _languageCubit.setCurrentLanguage(selectedLocal!, true);
                    //   Navigator.pushNamed(context, PageRoutes.loginNavigator);
                    // }),
                  ],
                ),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    width: 160,
                    height:50,
                    child: RaisedButton(
                        color:  theme.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text("Countinue",style:TextStyle(
                            color:Colors.white,fontSize:21
                        )),
                        onPressed:(){

                          print("ppp");
                          print("ll="+selectedLocal!.toString());
                          _languageCubit.setCurrentLanguage(selectedLocal!, true);
                          print("ll="+selectedLocal!.toString());
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) =>
                          //       LoginNavigator()),
                          // );
                          Navigator.pushNamed(context, PageRoutes.loginNavigator);
                          if(email=='x'){
                            _languageCubit.setCurrentLanguage(selectedLocal!, true);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  LoginNavigator()),
                            );
                          }
                          else{
                            _languageCubit.setCurrentLanguage(selectedLocal!, true);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  BottomNavigation()),
                            );
                          }

                          //  Get.to(BottomNavigation());
                        }),
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: CustomButton(
                //       label: 'Continue',
                //       onTap: () {
                //         _languageCubit.setCurrentLanguage(selectedLocal!, true);
                //          Navigator.pushNamed(context, PageRoutes.loginNavigator);
                //       }),
                // ),
              ],
            ),
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          ),
        );
      },
    );
  }
}
