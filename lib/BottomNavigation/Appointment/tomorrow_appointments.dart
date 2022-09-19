
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TomorrowAppWidget extends StatefulWidget {


  @override
  State<TomorrowAppWidget> createState() => _PdfWidgetState();
}

class _PdfWidgetState extends State<TomorrowAppWidget> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('doctors')
        .where('day', isEqualTo:'tomorrow')
        //   .where('doctor', isEqualTo: doctor)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: Text('Loading'));
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return Expanded(
                child: ListView.builder(
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
                                      Container(
                                        width: 420,
                                        height: 160,
                                        child: Image.network(
                                            posts['image'],
                                            fit: BoxFit.fill),
                                      ),
                                      SizedBox(height: 20),
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

                                // Get.to( PdfScreen(
                                //   pdf_url: posts['pdf'],
                                // ));
                              },
                            ),
                          ));
                    }),
              );
          }
        });
  }

}
