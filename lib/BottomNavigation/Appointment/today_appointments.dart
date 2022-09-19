
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctoworld_doctor/BottomNavigation/Appointment/chat_page.dart';
import 'package:doctoworld_doctor/BottomNavigation/Appointment/chating%20screen.dart';
import 'package:doctoworld_doctor/Routes/routes.dart';
import 'package:doctoworld_doctor/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodayAppWidget extends StatefulWidget {


  @override
  State<TodayAppWidget> createState() => _PdfWidgetState();
}

class _PdfWidgetState extends State<TodayAppWidget> {
  @override
  Widget build(BuildContext context) {
    return

      StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('profiles')

            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: Text('Loading'));
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return// Text("oo", style:TextStyle(color:Colors.red),);
                ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot posts =
                      snapshot.data!.docs[index];
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 220,
                            child: InkWell(
                              child: Card(
                                color: Colors.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft:
                                          Radius.circular(10),
                                          bottomRight:
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ]),
                                  child: Column(
                                    children: [
                                      SizedBox(height:4,),
                                      Directionality(
                                        textDirection:
                                        TextDirection.rtl,
                                        child: Container(
                                          child: Text(
                                            (posts['day']),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontFamily:
                                                "Reboto"),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height:4,),
                                      Container(
                                        width: 170,
                                        height: 110,
                                        child: Image.network(
                                            posts['image'],
                                            fit: BoxFit.fill),
                                      ),
                                      SizedBox(height: 5),
                                      Column(
                                        children: [
                                          Column(
                                            children: [
                                              Directionality(
                                                textDirection:
                                                TextDirection.rtl,
                                                child: Container(
                                                  child: Text(
                                                    (posts['name']),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontFamily:
                                                        "Reboto"),
                                                  ),
                                                ),
                                              ),
                                              Directionality(
                                                textDirection:
                                                TextDirection.rtl,
                                                child: Container(
                                                  child: Text(
                                                    (posts['time']),
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontFamily:
                                                        "Reboto"),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ChatingScreen(
                                    posts['image'], posts['name'],posts['des']
                                  )),
                                );
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => ChatScreen(name: posts['name'],
                                //       time: posts['time'], image: posts['image'])),
                                // );

                              },
                            ),
                          ));
                    });
          }
        });
  }

}
