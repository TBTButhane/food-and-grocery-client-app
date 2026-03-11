// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you/Controllers/auth_controller.dart';
import 'package:shop4you/util/user_details_repo.dart';
import 'package:shop4you/widgets/custom_loader.dart';
import 'package:shop4you/widgets/dimentions.dart';
import 'package:shop4you/screens/Auth/sign_up.dart';
import 'package:shop4you/widgets/app_text_field.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading
            ? Padding(
                padding: EdgeInsets.only(
                    top: Dimensions.height45 + Dimensions.height20),
                child: Column(children: [
                  Container(
                    height: Dimensions.height30 * 6,
                    width: double.maxFinite,
                    child: Center(
                      child: Image.asset("assets/images/shop4you.jpeg",
                          fit: BoxFit.cover, width: double.maxFinite),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(left: Dimensions.width15),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello",
                          style: TextStyle(
                              fontSize: Dimensions.height45 +
                                  Dimensions.height45 -
                                  Dimensions.height20,
                              color: Colors.black),
                        ),
                        Text(
                          "Welcome, Please sign in to your account",
                          style: TextStyle(
                              fontSize: Dimensions.height20 * 0.7,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10 + Dimensions.height20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //Email TextField
                          AppTextField(
                            icon: Icons.mail_outlined,
                            type: TextInputType.emailAddress,
                            hintText: "Enter your email",
                            controller: emailController,
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          //Password TextField
                          AppTextField(
                            icon: Icons.password_outlined,
                            type: TextInputType.text,
                            isPassword: true,
                            hintText: "Enter your Password",
                            controller: passwordController,
                          ),
                          SizedBox(
                            height:
                                Dimensions.height20 + Dimensions.height20 / 2,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.put(UserDetailRepo(getStorage: Get.find()));
                              Get.put(
                                  AuthController(userDetailRepo: Get.find()));
                              AuthController.instance.login(
                                  emailController.text.trim(),
                                  passwordController.text.trim());
                            },
                            child: Container(
                              width: Dimensions.screenWidth / 2,
                              height: Dimensions.screenHeight / 12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius30),
                                  color: Colors.green),
                              child: Center(
                                  child: Text(
                                "Sign in",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimensions.font20 +
                                        Dimensions.font20 / 2),
                              )),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Don\'t have an account, ",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimensions.font16),
                                children: [
                                  TextSpan(
                                    //TODO: Change this to appropreate page
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Get.to(() => SignUp()),
                                    text: "Create?",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Dimensions.font16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              )
            : const Center(child: CustomLoader());
      }),
    );
  }
}
