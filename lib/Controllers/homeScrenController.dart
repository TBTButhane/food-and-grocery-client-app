// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get.dart';
// import 'package:shop4you/models/res_model.dart';

// class HomeScreenController extends GetxController {
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   late CollectionReference collectionReference;
//   RxList<Shop4You> restaurents = RxList<Shop4You>([]);

//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     collectionReference = firebaseFirestore.collection("restaurants");
//     // restaurents.bindStream(getAllRestaurants());
//   }

//   // Stream<List<Shop4You>> getAllRestaurants() {
//   //   // => collectionReference
//   //   //   .snapshots()
//   //   //   .map((event) => event.docs.map((e) => Shop4You.fromJson(e)).toList());
//   //   var allRes = firebaseFirestore
//   //       .collection("restaurants")
//   //     .()
//   //       .map((event) => event.docs.map((e) => Shop4You.fromJson(e)).toList());
//   //   print("this is all res:" + allRes.toString());

//   //   return allRes;
//   // }
// }
