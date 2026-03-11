// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you/Controllers/auth_controller.dart';
import 'package:shop4you/routes/route_helper.dart';
import 'package:shop4you/screens/Auth/sign_in.dart';
import 'package:shop4you/widgets/big_text.dart';
import 'package:shop4you/widgets/custom_button.dart';
import 'package:shop4you/widgets/custom_loader.dart';
import 'package:shop4you/widgets/dimentions.dart';
import 'package:shop4you/widgets/account_widget.dart';
import 'package:shop4you/widgets/appicon.dart';
import 'package:shop4you/widgets/app_icon_text.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    bool _isloggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isloggedIn) {
      Get.find<AuthController>().getUserdata();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Profile",
            style: TextStyle(fontSize: 24, color: Colors.white)),
        centerTitle: true,
      ),
      body: GetBuilder<AuthController>(builder: ((controller) {
        return controller.isLoading
            ? Center(child: CustomLoader())
            : controller.isLoggedIn()
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        AppIcon(
                            icon: Icons.person,
                            backgroundColor: Color.fromARGB(255, 63, 102, 134),
                            iconColor: Colors.white,
                            iconSize: Dimensions.height45 + Dimensions.height30,
                            size: Dimensions.height15 * 10),
                        SizedBox(
                          height: Dimensions.height30,
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              //User Acount Name
                              AccountWidget(
                                  appIconAndText: AppIconAndText(
                                icon: Icons.person,
                                text: controller.storedUserDetails == null
                                    ? ""
                                    : controller.storedUserDetails!.name,
                                fontSize: 18,
                                iconSize: Dimensions.iconSize24 + 8,
                                size: Dimensions.height20 + Dimensions.height30,
                                iconColr: Colors.white,
                                backgroundColor:
                                    Color.fromARGB(255, 63, 102, 134),
                              )),
                              SizedBox(
                                height: Dimensions.height15,
                              ),
                              //User Account Number
                              AccountWidget(
                                  appIconAndText: AppIconAndText(
                                icon: Icons.phone,
                                text: controller.storedUserDetails == null
                                    ? ""
                                    : controller.storedUserDetails!.phoneNumber,
                                fontSize: 18,
                                iconSize: Dimensions.iconSize24 + 8,
                                size: Dimensions.height20 + Dimensions.height30,
                                iconColr: Colors.white,
                                backgroundColor: Colors.yellowAccent,
                              )),
                              SizedBox(
                                height: Dimensions.height15,
                              ),
                              //User Account Email Address
                              AccountWidget(
                                  appIconAndText: AppIconAndText(
                                icon: Icons.mail,
                                text: controller.storedUserDetails == null
                                    ? ""
                                    : controller.storedUserDetails!.email,
                                fontSize: 18,
                                iconSize: Dimensions.iconSize24 + 8,
                                size: Dimensions.height20 + Dimensions.height30,
                                iconColr: Colors.white,
                                backgroundColor: Colors.yellowAccent,
                              )),
                              SizedBox(
                                height: Dimensions.height15,
                              ),
                              //User Account addrress
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getAddress(""));
                                },
                                child: AccountWidget(
                                    appIconAndText: AppIconAndText(
                                  icon: Icons.location_on,
                                  text: "Fill your location",
                                  fontSize: 18,
                                  iconSize: Dimensions.iconSize24 + 8,
                                  size:
                                      Dimensions.height20 + Dimensions.height30,
                                  iconColr: Colors.white,
                                  backgroundColor: Colors.yellowAccent,
                                )),
                              ),
                              SizedBox(
                                height: Dimensions.height15,
                              ),
                              //User Account Message
                              AccountWidget(
                                  appIconAndText: AppIconAndText(
                                icon: Icons.message,
                                text: "Message",
                                fontSize: 18,
                                iconSize: Dimensions.iconSize24 + 8,
                                size: Dimensions.height20 + Dimensions.height30,
                                iconColr: Colors.white,
                                backgroundColor: Colors.redAccent,
                              )),
                              SizedBox(
                                height: Dimensions.height15,
                              ),
                              //User Account support
                              AccountWidget(
                                  appIconAndText: AppIconAndText(
                                icon: Icons.unsubscribe_rounded,
                                text: "Support",
                                fontSize: 18,
                                iconSize: Dimensions.iconSize24 + 8,
                                size: Dimensions.height20 + Dimensions.height30,
                                iconColr: Colors.white,
                                backgroundColor: Colors.greenAccent,
                              )),
                              SizedBox(
                                height: Dimensions.height15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.find<AuthController>().logOut();
                                  if (auth.currentUser == null) {
                                    Get.offAll(() => SignIn());
                                  }
                                },
                                child: AccountWidget(
                                    appIconAndText: AppIconAndText(
                                  icon: Icons.exit_to_app,
                                  text: "Log-out",
                                  fontSize: 18,
                                  iconSize: Dimensions.iconSize24 + 8,
                                  size:
                                      Dimensions.height20 + Dimensions.height30,
                                  iconColr: Colors.white,
                                  backgroundColor: Colors.red,
                                )),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  )
                : SizedBox(
                    width: Dimensions.screenWidth,
                    height: Dimensions.screenHeight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BigText(
                            text: "Sign in to view your Profile",
                            isBold: true,
                            fontSize: Dimensions.font16 + 2,
                            fontColor: Colors.green,
                          ),
                          SizedBox(
                            height: Dimensions.height30,
                          ),
                          CustomButton(
                            buttonText: "Sign in",
                            fontSize: Dimensions.font16,
                            height: Dimensions.height45 + 10,
                            width: Dimensions.screenWidth,
                            onPressed: () {
                              Get.offNamed(RouteHelper.getSignInPage());
                            },
                            icon: Icons.login_rounded,
                          )
                        ],
                      ),
                    ),
                  );
      })),
    );
  }
}
