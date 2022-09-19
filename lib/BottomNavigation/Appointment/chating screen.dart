

  import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctoworld_doctor/BottomNavigation/bottom_navigation.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ChatingScreen extends StatefulWidget {

   String image,name,des;


   ChatingScreen(this.image, this.name,this.des);

  @override
  State<ChatingScreen> createState() => _ChatingScreenState();
}

class _ChatingScreenState extends State<ChatingScreen> {

  @override
   Widget build(BuildContext context) {
    final box = GetStorage();
    String name=box.read('name');
    String email=box.read('email');
    var locale = AppLocalizations.of(context)!;
     return Scaffold(
       body:Column(
         children: [
           SizedBox(
             height: 20,
           ),
           Row(
             children: [
                SizedBox(width:50,),
               Container(
                   width:140,
                   height:190,
                   child: Image.network(widget.image)),

               SizedBox(width:30,),

               Text(widget.name,style:TextStyle(
                 color:Colors.black,
                 fontSize:21
               ),)
             ],
           ),
           SizedBox(
             height: 30,
           ),

           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text(widget.des,style:TextStyle(
               color:Colors.grey,fontSize:14
             ),),
           ),

           SizedBox(
             height: 30,
           ),
           Container(
             width:176,
             height: 50,
             child: RaisedButton(
               color:Colors.indigoAccent,
                 child:Text(locale.bookwith.toString()+" "+widget.name,style:TextStyle(
                   color:Colors.white,
                   fontSize:19
                 )),
                 onPressed:() async {

                   await FirebaseFirestore.instance.collection('requests')
                      // .where('email',isEqualTo:email)
                       .add({
                    'guest':'guest = '+" "+name,
                     'doctor':'doctor name = '+widget.name
                   }).then((value) async {

                     await Flushbar(
                       backgroundColor:Colors.lightBlue,
                         title: 'Done',
                         message:
                       locale.requestsent,
                     duration: Duration(seconds: 2),
                     ).show(context);



                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) =>
                           BottomNavigation()),
                     );

                   });

               print("bb");
             }),
           )
         ],
       )
     );
   }
}
