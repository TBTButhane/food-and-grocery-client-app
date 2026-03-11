import 'dart:convert';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you/models/userdata_Model.dart';
import 'package:shop4you/routes/route_helper.dart';
import 'package:shop4you/screens/Auth/sign_in.dart';
import 'package:shop4you/util/user_details_repo.dart';

class AuthController extends GetxController {
  final UserDetailRepo userDetailRepo;
  AuthController({required this.userDetailRepo});
  //TODO:Check Vidoe part 2 on 8hrs: 25mins
  static AuthController instance = Get.find();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  UserDetails? storedUserDetails;
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebase_Db = FirebaseFirestore.instance;
  late String? mToken;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _intialScreen);
  }



  //Firebase auth
  _intialScreen(User? user) async {
    if (user == null) {
      // Get.offAll(() => SignIn());
      Timer(const Duration(seconds: 1), (() {
        Get.offNamed(RouteHelper.getsplash());
        // AuthController.instance.redirect(user);
      }));
    } else {

      await getUserdata();

      Get.offNamed(RouteHelper.getIntialPage());
    }
  }

  Future<void> getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      mToken = token;
    });
  }

  Future<void> saveToken(String? token, String userId) async {
    Map<String, dynamic> userToken = {"token": token};
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update(userToken);
  }

  Future<void> register(
      String email, String password, String name, String phone) async {
    _isLoading = true;
    update();
    await getToken();

    try {
      final userData = firebase_Db.collection('users');

      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // UserDetails userDetails = UserDetails(name: name, email: email, phoneNumber: phone, address: )
      await userData.doc(auth.currentUser!.uid).set({
        "email": email,
        "name": name,
        "phone": phone,
        "token": mToken,
        "address_list": null
      }).whenComplete(() => Get.offNamed(RouteHelper.getAddress("signUp")));
    } catch (e) {
      Get.snackbar("Error Registering", "$e",
          colorText: Colors.white, backgroundColor: Colors.green);
    }
    _isLoading = false;
    update();
  }

  Future<void> login(String email, password) async {
    _isLoading = true;
    update();
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await getToken();
      await saveToken(mToken, auth.currentUser!.uid);
      await getUserdata();
    } catch (e) {
      print(e);
      if (e ==
          "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted") {
        Get.snackbar("Error Log-in", "User not available",
            colorText: Colors.white, backgroundColor: Colors.green);
      } else if (e == "[firebase_auth/unknown] Given String is empty or null") {
        Get.snackbar("Error Log-in", "Missing email or password",
            colorText: Colors.white, backgroundColor: Colors.green);
      } else {
        Get.snackbar("Error Log-in", "User not available",
            colorText: Colors.white, backgroundColor: Colors.green);
      }
    }
    _isLoading = false;
    update();
  }

  logOut() async {
    await auth.signOut();
  }

  bool isLoggedIn() {
    bool isLoggedIn = false;
    _isLoading = true;
    // update();
    if (auth.currentUser != null) {
      isLoggedIn = true;
      _isLoading = false;
      // update();
      return isLoggedIn;
    } else {
      _isLoading = false;
      // update();
      return isLoggedIn;
    }
  }

  Future<void> getUserdata() async {
    final ref = firebase_Db.collection('users').doc(auth.currentUser!.uid);
    final docSnap = await ref.get();
    final user = docSnap.data();
    _isLoading = true;
    update();
    if (user != null) {
      var saveUserDetails = jsonEncode(user);
      //save userdata locally
      userDetailRepo.storeUserProfileData(saveUserDetails);
      //convert Stored data and show in profile screen
      var getSavedString = jsonDecode(userDetailRepo.getStoredUserData());
      storedUserDetails = UserDetails.fromJson(getSavedString);

      print(storedUserDetails!.name);
    } else {
      print("couldn't get user data");
    }
    _isLoading = false;
    update();
  }

  bool savedDatalocally() {
    bool dataSaved = false;
    if (storedUserDetails != null) {
      dataSaved = true;
    } else {
      dataSaved = false;
    }

    return dataSaved;
  }
}
