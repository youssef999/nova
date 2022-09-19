

 import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/BottomNavigation/Appointment/my_appointments.dart';
import 'package:doctoworld_doctor/BottomNavigation/Appointment/today_appointments.dart';
import 'package:doctoworld_doctor/BottomNavigation/Appointment/tomorrow_appointments.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:flutter/material.dart';

class DoctorsAppointments extends StatelessWidget {
   const DoctorsAppointments({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     var locale = AppLocalizations.of(context)!;

return Scaffold(
       appBar: AppBar(
         automaticallyImplyLeading: false,
         title: FadedScaleAnimation(
           Text(
             locale.myAppointments!,
             style: Theme.of(context)
                 .textTheme
                 .bodyText2!
                 .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
           ),
           durationInMilliseconds: 400,
         ),
         centerTitle: true,
         actions: [
           IconButton(
             icon: Icon(
               Icons.history,
               size: 22,
             ),
             color: Theme.of(context).primaryColor,
             onPressed: () {},
           )
         ],
       ),
       body:  TodayAppWidget(),
         // ListView(
         //   children: [
         //     SizedBox(height: 20,),
         //     Container(
         //       width: MediaQuery.of(context).size.width,
         //       padding: EdgeInsets.all(20.0),
         //       color: Theme.of(context).primaryColorLight,
         //       child:Text(locale.today!,style:TextStyle(color:Colors.grey,fontSize:17),)
         //     ),
         //     SizedBox(height: 20,),
         //     TodayAppWidget(),
         //     SizedBox(height: 20,),
         //     Container(
         //         width: MediaQuery.of(context).size.width,
         //         padding: EdgeInsets.all(20.0),
         //         color: Theme.of(context).primaryColorLight,
         //         child:Text(locale.tomorrow!,style:TextStyle(color:Colors.grey,fontSize:17),)
         //     ),
         //     SizedBox(height: 20,),
         //     TomorrowAppWidget(),
         //   ],
         // ),

     );
   }
 }
