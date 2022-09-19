

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctoworld_doctor/BottomNavigation/bottom_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
//getx Support disaple automatically



class AuthViewModel extends GetxController {


  FirebaseAuth _auth = FirebaseAuth.instance;

  String ? email, password, name,phone ,codeV,code;
  String ? country,city,details,mobile,brand_name,cat;
  // TextEditingController email1,pass1,name1,code1;
  var verificationId;
 // Rx<User> _user = Rx<User>();
 // get user => _user.value?.email;
 // final LocalStorageData localStorageData = Get.find();



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   // _user.bindStream(_auth.authStateChanges());
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }


// Future<void> sginInWithGoogle() async /* Sgin in with google method*/
//   {
//     GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
//   }
//
//   Future<void> googleSignInMehtod() async {
//     final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//     GoogleSignInAuthentication googleSignInAuthentication =
//         await googleUser.authentication;
//  print("cc=" + googleUser.toString());
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       idToken: googleSignInAuthentication.idToken,
//       accessToken: googleSignInAuthentication.accessToken,
//     );
//
//     print("cc=" + credential.toString());
//     //UserCredential userCredential=
//     await _auth.signInWithCredential(credential).then((user) async {
//       await FireStoreUser().getCurrentUser(user.user.uid).then((value) {
//         setUser(UserModel.fromJson(value.data()));
//         print("Userr = " + _user.toString());
//       });
//       saveUser(user);
//     });
//     Get.offAll(HomeView());
//   }



  void signInWithEmailAndPassword(String e,String p) async {
    await Firebase.initializeApp();
    print("ooo");

     print("e="+e);
     print("p="+p);

    try {

      await _auth
          .signInWithEmailAndPassword(email: e, password: p)
          .then((value) async {
            print("vvvv");
            final box = GetStorage();
            box.write('email', e);
            box.write('pass',p);
            box.write('name', 'User');
            print("xsxx");
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => BottomNavigation()),
            // );
           Get.offAll( BottomNavigation());
        // await FireStoreUser().getCurrentUser(value.user.uid).then((value) {
        //   setUser(UserModel.fromJson(value.data()));
        //   print("Userr = " + _user.toString());
        // });
      });
      // final box = GetStorage();
      // box.write('email', e);
      // box.write('pass',p);
      // print("xsxx");
     //Get.offAll(ControlView());
     // if(box_country=='x'){
     //   Get.offAll(CountryView());
     // }
     // else{
     //   Get.offAll(ControlView());
     // }


    } catch (e) {
      Get.snackbar("Error login Acoount", e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
    print("xsxx");
  }


  void createAccountWithEmailAndPassword(String e,String p ,String n) async {

    final box = GetStorage();
    try {
      await _auth
          .createUserWithEmailAndPassword(email: e, password: p,  )
          .then((user) async {
        //saveUser(user);
        final box1=box.write('email',e);
        final box2=box.write('pass',p);
        final box3=box.write('name',n);

        await FirebaseFirestore.instance.collection('profiles').add({
          'name': n,
          'email': e,
          'image':"http://pngimg.com/uploads/doctor/doctor_PNG16041.png",
          'review':"",
          'stars':2.1,
          'time':"",
          "day":"",
          "comment":[]
        });

        Get.off(BottomNavigation());

      });

    } catch (e) {
      Get.snackbar("Error login Acoount", e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
  }



  Future verifyPhoneNumber()async{

_auth.verifyPhoneNumber(phoneNumber: phone,
    verificationCompleted: (phoneAuthCredential) async{

     print("ppp"+phoneAuthCredential.toString());
    },
    verificationFailed: (verificationFailed)async{
      print("ppp"+verificationFailed.toString());
    },
    codeSent:(verficationId,resendingToken)async{
      this.verificationId=verficationId;
      update();
      print("sss="+verficationId);
    },
    codeAutoRetrievalTimeout: (verificationId)async{});

   //Get.to(VerifyOtp());
  }


  // Future sendCodeToFireBase(String code)async{
  //
  //      if(this.verificationId!=null){
  //        var credential=PhoneAuthProvider.credential(
  //            verificationId: verificationId, smsCode: code);
  //
  //        await _auth.signInWithCredential(credential).then((value){
  //
  //          Get.to(ControlView());
  //        }).whenComplete(() {
  //
  //        })
  //            .onError((error, stackTrace) {
  //
  //                print("error");
  //        });
  //      }
  // }


   void ResetPassword(String e)async{

     try {
       await  _auth.sendPasswordResetEmail(email: e).then((value) {
      //   Get.to(ControlView());
         Get.snackbar('تم',
             'ارسلنا لك رابط علي الايميل تستطيع اعادة كلمة المرور من خلاله',
             backgroundColor: Colors.lightGreen, colorText: Colors.white,
             duration: Duration(seconds: 10)
         );
       });
     } on FirebaseAuthException catch (e) {
       print("PPP"+e.code);
      // print("eeee="+e.message);

       Get.snackbar('!!!!!', 'تاكد من ان هذا الايميل صحيح و مسجل داخل Luban',backgroundColor: Colors.lightGreen,colorText:Colors.white,
       duration:Duration(seconds:10));
// show the snackbar here
     }
 //   _auth.sendPasswordResetEmail(email: email);


   }

  // Future<void> saveUser(UserCredential user) async {
  //   UserModel userModel = UserModel(
  //     user.user!.uid,
  //     user.user!.email,
  //     name == null ? user.user.displayName : name,
  //     " ",
  //   );
  //   await FireStoreUser().addUserToFireStore(userModel);
  //   setUser(userModel);
  // }

  // void setUser(UserModel userModel) async {
  //   await localStorageData.setUser(userModel);
  // }



}
