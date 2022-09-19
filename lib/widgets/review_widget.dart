
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctoworld_doctor/BottomNavigation/Appointment/chat_page.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class ReviewWidget extends StatefulWidget {



  @override
  State<ReviewWidget> createState() => _PdfWidgetState();
}

class _PdfWidgetState extends State<ReviewWidget> {

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String email=box.read('email');
    var locale = AppLocalizations.of(context)!;

    return  StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('profiles').where('email',isEqualTo:email)

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
                      return

                        Column(
                          children: [
                            Container(
                              child:Text(locale.reviews.toString(),style:TextStyle(
                                color:Colors.black,fontSize:29
                              )),
                            ),
                            Row(
                              children: [
                                SizedBox(width:12,),
                                Container(
                                  width: 120,
                                  //height: 120,
                                  child: Image.network(
                                      posts['image'],
                                      fit: BoxFit.fill),
                                ),
                                SizedBox(width:40,),
                                Container(
                                  child: Text(
                                    (posts['name']),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 21,
                                        fontWeight:
                                        FontWeight.bold,
                                        fontFamily:
                                        "Reboto"),
                                  ),
                                ),

                              ],
                            ),
                                          SizedBox(height:10,),
                                          Padding(
                                            padding: const EdgeInsets.all(1),
                                            child: Text(
                                                (posts['stars'].toString()),
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 21,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontFamily:
                                                    "Reboto"),
                                              ),
                                          ),

                      RatingBarIndicator(
                                          rating: posts['stars'],
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 30.0,
                                          unratedColor: Colors.amber.withAlpha(50),
                                          //direction: _isVertical ? Axis.vertical : Axis.horizontal,
                                        ),
                            SizedBox(height: 15,),
                            Text(locale.comments.toString(),style: TextStyle(
                              color:Colors.black,
                              fontSize: 21
                            ),),
                            SizedBox(height: 5,),
                            for(int i=0;i<posts['comment'].length;i++)
                            Container(
                              height:90,
                              child: Card(
                                color:Colors.white54,
                                child: Padding(
                                  padding: const EdgeInsets.only(top:12),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          SizedBox(width:5,),

                                          Center(
                                            child: Text(
                                              (posts['comment'][i]['name'].toString()),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.w700,
                                                  fontFamily:
                                                  "Reboto"),
                                            ),
                                          ),
                                          SizedBox(width:20,),
                                          Padding(
                                            padding: const EdgeInsets.all(1),
                                            child: Text(
                                              (posts['comment'][i]['stars'].toString()??""),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  fontFamily:
                                                  "Reboto"),
                                            ),
                                          ),
                                          SizedBox(width:5,),
                                          RatingBarIndicator(
                                            rating: posts['comment'][i]['stars']??0.0,
                                            itemBuilder: (context, index) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: 16.0,
                                            unratedColor: Colors.amber.withAlpha(50),
                                            //direction: _isVertical ? Axis.vertical : Axis.horizontal,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          SizedBox(width: 40,),
                                          Text(
                                            (posts['comment'][i]['com']??"".toString()),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight:
                                                FontWeight.normal,
                                                fontFamily:
                                                "Reboto"),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Container(
                            //     height: 1000,
                            //     child: Container(
                            //       decoration: BoxDecoration(
                            //           color: Colors.white,
                            //           borderRadius: BorderRadius.only(
                            //               topLeft: Radius.circular(10),
                            //               topRight: Radius.circular(10),
                            //               bottomLeft:
                            //               Radius.circular(10),
                            //               bottomRight:
                            //               Radius.circular(10)),
                            //           boxShadow: [
                            //             BoxShadow(
                            //               color: Colors.grey
                            //                   .withOpacity(0.5),
                            //               spreadRadius: 5,
                            //               blurRadius: 7,
                            //               offset: Offset(0,
                            //                   3), // changes position of shadow
                            //             ),
                            //           ]),
                            //       child: Row(
                            //         children: [
                            //           SizedBox(height:4,),
                            //           Directionality(
                            //             textDirection:
                            //             TextDirection.rtl,
                            //             child: Container(
                            //               child: Text(
                            //                 (posts['name']),
                            //                 style: TextStyle(
                            //                     color: Colors.grey,
                            //                     fontSize: 16,
                            //                     fontWeight:
                            //                     FontWeight.bold,
                            //                     fontFamily:
                            //                     "Reboto"),
                            //               ),
                            //             ),
                            //           ),
                            //           SizedBox(width:4,),
                            //           Container(
                            //             width: 120,
                            //             //height: 120,
                            //             child: Image.network(
                            //                 posts['image'],
                            //                 fit: BoxFit.fill),
                            //           ),
                            //           SizedBox(height: 5),
                            //
                            //           Column(
                            //             children: [
                            //               Column(
                            //                 children: [
                            //                   Directionality(
                            //                     textDirection:
                            //                     TextDirection.rtl,
                            //                     child: Container(
                            //                       child: Text(
                            //                         (posts['stars'].toString()),
                            //                         style: TextStyle(
                            //                             color: Colors.black,
                            //                             fontSize: 21,
                            //                             fontWeight:
                            //                             FontWeight.bold,
                            //                             fontFamily:
                            //                             "Reboto"),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                   RatingBarIndicator(
                            //                     rating: posts['stars'],
                            //                     itemBuilder: (context, index) => Icon(
                            //                         Icons
                            //                             .star_half_outlined ??
                            //                             Icons.star,
                            //                       color: Colors.amber,
                            //                     ),
                            //                     itemCount: 5,
                            //                     itemSize: 50.0,
                            //                     unratedColor: Colors.amber.withAlpha(50),
                            //                     //direction: _isVertical ? Axis.vertical : Axis.horizontal,
                            //                   ),
                            //                 ],
                            //               ),
                            //               SizedBox(
                            //                 height: 7,
                            //               ),
                            //
                            //             ],
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   )),
                          ],
                        );
                    });
          }
        });
  }

}
