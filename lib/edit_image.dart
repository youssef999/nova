// // Copyright 2013 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.
//
// // ignore_for_file: public_member_api_docs
//
// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'Theme/colors.dart';
//
//
//
//
// class EditImage extends StatelessWidget {
//   const EditImage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  MyHomePage(title: '');
//
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, this.title}) : super(key: key);
//
//   final String? title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   List<XFile>? _imageFileList;
//
//   void _setImageFileListFromFile(XFile? value) {
//     _imageFileList = value == null ? null : <XFile>[value];
//   }
//
//   dynamic _pickImageError;
//   bool isVideo = false;
//
//
//   String? _retrieveDataError;
//
//   final ImagePicker _picker = ImagePicker();
//   final TextEditingController maxWidthController = TextEditingController();
//   final TextEditingController maxHeightController = TextEditingController();
//   final TextEditingController qualityController = TextEditingController();
//
//
//
//   Future<void> _onImageButtonPressed(ImageSource source,
//       {BuildContext? context, bool isMultiImage = false}) async {
//
//   if (isMultiImage) {
//       await _displayPickImageDialog(context!,
//               (double? maxWidth, double? maxHeight, int? quality) async {
//             try {
//               final List<XFile>? pickedFileList = await _picker.pickMultiImage(
//                 maxWidth: maxWidth,
//                 maxHeight: maxHeight,
//                 imageQuality: quality,
//               );
//               setState(() {
//                 _imageFileList = pickedFileList;
//               });
//             } catch (e) {
//               setState(() {
//                 _pickImageError = e;
//               });
//             }
//           });
//     }
//   else {
//       await _displayPickImageDialog(context!,
//               (double? maxWidth, double? maxHeight, int? quality) async {
//             try {
//               final XFile? pickedFile = await _picker.pickImage(
//                 source: source,
//                 maxWidth: maxWidth,
//                 maxHeight: maxHeight,
//                 imageQuality: quality,
//               );
//               setState(() {
//                 _setImageFileListFromFile(pickedFile);
//               });
//             } catch (e) {
//               setState(() {
//                 _pickImageError = e;
//               });
//             }
//           });
//     }
//   }
//
//   // @override
//   // void deactivate() {
//   //   if (_controller != null) {
//   //     _controller!.setVolume(0.0);
//   //     _controller!.pause();
//   //   }
//   //   super.deactivate();
//   // }
//
//   @override
//   void dispose() {
//     //_disposeVideoController();
//     maxWidthController.dispose();
//     maxHeightController.dispose();
//     qualityController.dispose();
//     super.dispose();
//   }
//
//
//
//
//
//   Widget _previewImages() {
//     final Text? retrieveError = _getRetrieveErrorWidget();
//     if (retrieveError != null) {
//       return retrieveError;
//     }
//     if (_imageFileList != null) {
//       return Semantics(
//         label: 'image_picker_example_picked_images',
//         child: ListView.builder(
//           key: UniqueKey(),
//           itemBuilder: (BuildContext context, int index) {
//             // Why network for web?
//             // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
//             return Semantics(
//               label: 'image_picker_example_picked_image',
//               child: kIsWeb
//                   ? Image.network(_imageFileList![index].path)
//                   : Image.file(File(_imageFileList![index].path)),
//             );
//           },
//           itemCount: _imageFileList!.length,
//         ),
//       );
//     } else if (_pickImageError != null) {
//       return Text(
//         'Pick image error: $_pickImageError',
//         textAlign: TextAlign.center,
//       );
//     } else {
//       return const Text(
//         'You have not yet picked an image.',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
//
//   Widget _handlePreview() {
//     return _previewImages();
//
//   }
//
//   Future<void> retrieveLostData() async {
//     final LostDataResponse response = await _picker.retrieveLostData();
//     if (response.isEmpty) {
//       return;
//     }
//     if (response.file != null) {
//       if (response.type == RetrieveType.video) {
//         print("vv");
//         // isVideo = true;
//         // await _playVideo(response.file);
//       } else {
//         isVideo = false;
//         setState(() {
//           if (response.files == null) {
//             _setImageFileListFromFile(response.file);
//           } else {
//             _imageFileList = response.files;
//           }
//         });
//       }
//     } else {
//       _retrieveDataError = response.exception!.code;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('change image '),
//       // ),
//       body:
//       Center(
//         child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
//             ? FutureBuilder<void>(
//           future: retrieveLostData(),
//           builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//             switch (snapshot.connectionState) {
//               case ConnectionState.none:
//               case ConnectionState.waiting:
//                 return const Text(
//                   'You have not yet picked an image.',
//                   textAlign: TextAlign.center,
//                 );
//               case ConnectionState.done:
//                 return _handlePreview();
//               default:
//                 if (snapshot.hasError) {
//                   return Text(
//                     'Pick image/video error: ${snapshot.error}}',
//                     textAlign: TextAlign.center,
//                   );
//                 } else {
//                   return const Text(
//                     'You have not yet picked an image.',
//                     textAlign: TextAlign.center,
//                   );
//                 }
//             }
//           },
//         )
//             : _handlePreview(),
//       ),
//       floatingActionButton: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             Semantics(
//               label: 'image_picker_example_from_gallery',
//               child: FloatingActionButton(
//                 backgroundColor: Colors.red,
//                 onPressed: () {
//                   isVideo = false;
//                   _onImageButtonPressed(ImageSource.gallery, context: context);
//                 },
//                 heroTag: 'image0',
//                 tooltip: 'Pick Image from gallery',
//                 child: const Icon(Icons.photo),
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//                 height:80,
//                 child: RaisedButton(
//                     color:primaryColor,
//                     child: Text("Change Profile Picture",
//                     style: TextStyle(
//                       color:Colors.white
//                     ),
//                     ),
//                     onPressed:(){
//
//                     }))
//
//             // Padding(
//             //   padding: const EdgeInsets.only(top: 16.0),
//             //   child: FloatingActionButton(
//             //     onPressed: () {
//             //       isVideo = false;
//             //       _onImageButtonPressed(
//             //         ImageSource.gallery,
//             //         context: context,
//             //         isMultiImage: true,
//             //       );
//             //     },
//             //     heroTag: 'image1',
//             //     tooltip: 'Pick Multiple Image from gallery',
//             //     child: const Icon(Icons.photo_library),
//             //   ),
//             // ),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Text? _getRetrieveErrorWidget() {
//     if (_retrieveDataError != null) {
//       final Text result = Text(_retrieveDataError!);
//       _retrieveDataError = null;
//       return result;
//     }
//     return null;
//   }
//
//   Future<void> _displayPickImageDialog(
//
//       BuildContext context, OnPickImageCallback onPick) async {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return
//             AlertDialog(
//             title: const Text('Add optional parameters'),
//             content: Column(
//               children: <Widget>[
//                 TextField(
//                   controller: maxWidthController,
//                   keyboardType:
//                   const TextInputType.numberWithOptions(decimal: true),
//                   decoration: const InputDecoration(
//                       hintText: 'Enter maxWidth if desired'),
//                 ),
//                 TextField(
//                   controller: maxHeightController,
//                   keyboardType:
//                   const TextInputType.numberWithOptions(decimal: true),
//                   decoration: const InputDecoration(
//                       hintText: 'Enter maxHeight if desired'),
//                 ),
//                 TextField(
//                   controller: qualityController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                       hintText: 'Enter quality if desired'),
//                 ),
//               ],
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('CANCEL'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               TextButton(
//                   child: const Text('PICK'),
//                   onPressed: () {
//                     final double? width = maxWidthController.text.isNotEmpty
//                         ? double.parse(maxWidthController.text)
//                         : null;
//                     final double? height = maxHeightController.text.isNotEmpty
//                         ? double.parse(maxHeightController.text)
//                         : null;
//                     final int? quality = qualityController.text.isNotEmpty
//                         ? int.parse(qualityController.text)
//                         : null;
//                     onPick(width, height, quality);
//                     onPick(width, height, quality);
//                     Navigator.of(context).pop();
//                   }),
//             ],
//           );
//         });
//   }
// }
//
// typedef OnPickImageCallback = void Function(
//     double? maxWidth, double? maxHeight, int? quality);
//
// class AspectRatioVideo extends StatefulWidget {
//   const AspectRatioVideo( {Key? key}) : super(key: key);
//
//  // final VideoPlayerController? controller;
//
//   @override
//   AspectRatioVideoState createState() => AspectRatioVideoState();
// }
//
// class AspectRatioVideoState extends State<AspectRatioVideo> {
//   //VideoPlayerController? get controller => widget.controller;
//   bool initialized = false;
//
//   // void _onVideoControllerUpdate() {
//   //   if (!mounted) {
//   //     return;
//   //   }
//   //   // if (initialized != controller!.value.isInitialized) {
//   //   //   initialized = controller!.value.isInitialized;
//   //   //   setState(() {});
//   //   // }
//   // }
//
//   @override
//   void initState() {
//     super.initState();
//     //controller!.addListener(_onVideoControllerUpdate);
//   }
//
//   @override
//   void dispose() {
//    // controller!.removeListener(_onVideoControllerUpdate);
//     super.dispose();
//   }
//
//   Future uploadImage(context) async {
//     try {
//       FirebaseStorage storage =
//       FirebaseStorage(storageBucket: 'gs://fire999-6d8b9.appspot.com');
//
//       StorageReference ref = storage.ref().child(_image.path);
//       StorageUploadTask storageUploadTask = ref.putFile(_image);
//       StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
//
//       Scaffold.of(context).showSnackBar(SnackBar(
//         content: Text('success'),
//       ));
//       String url = await taskSnapshot.ref.getDownloadURL();
//       print('url $url');
//       setState(() {
//         _url = url;
//       });
//     } catch (ex) {
//       Scaffold.of(context).showSnackBar(SnackBar(
//         content: Text(ex.message),
//       ));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (initialized) {
//       return Center(
//         child:Container()
//       );
//     } else {
//       return Container();
//     }
//   }
// }