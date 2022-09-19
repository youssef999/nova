
import 'package:doctoworld_doctor/BottomNavigation/Account/change_language_page.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'Locale/language_cubit.dart';
import 'Locale/locale.dart';
import 'Routes/routes.dart';
import 'Theme/style.dart';

 void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: transparentColor));
  runApp(MultiBlocProvider(providers: [
    BlocProvider<LanguageCubit>(
      create: (context) => LanguageCubit(),
    ),
  ], child: Phoenix(child: DoctoWorldDoctor())));
}

class DoctoWorldDoctor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return

      BlocProvider<LanguageCubit>(
        create: (context) => LanguageCubit(),
        child: BlocBuilder<LanguageCubit, Locale>(
          builder: (_, locale) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                const AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.getSupportedLocales(),
              locale: locale,
              theme: lightTheme,
              home: ChangeLanguagePage(),
              routes: PageRoutes().routes(),
            );
          },
        ),
      );
  }
}
