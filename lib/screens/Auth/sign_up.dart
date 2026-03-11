import 'dart:ui';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you/Controllers/auth_controller.dart';
import 'package:shop4you/util/user_details_repo.dart';
import 'package:shop4you/widgets/custom_loader.dart';
import 'package:shop4you/widgets/dimentions.dart';
import 'package:shop4you/widgets/app_text_field.dart';
import 'package:shop4you/widgets/custome_snackbar.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();

    void _registration(AuthController controller) {
      String email = emailController.text.trim();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        shoeCustomSnackbar("Type in your name", title: "Name");
      } else if (email.isEmpty) {
        shoeCustomSnackbar("Type in your Email", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        shoeCustomSnackbar("Type in a valid Email", title: "Invalid Email");
      } else if (!GetUtils.isPhoneNumber(phone)) {
        shoeCustomSnackbar("Type in a Valid Phone number",
            title: "InValid Phone Number");
      } else if (phone.length < 10 || phone.length > 10) {
        shoeCustomSnackbar("Phone number must 10 digits",
            title: "Phone number length");
      } else if (password.isEmpty) {
        shoeCustomSnackbar("Type in your Password", title: "Password");
      } else if (password.length <= 7) {
        shoeCustomSnackbar("Password must be 8 charectors long",
            title: "Password Length");
      } else {
        Get.put(UserDetailRepo(getStorage: Get.find()));
        Get.put(AuthController(userDetailRepo: Get.find()));
        controller.register(email, password, name, phone);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return !authController.isLoading
              ? Column(children: [
                  Container(
                    height: Dimensions.height45 * 6,
                    width: double.maxFinite,
                    child: Center(
                      child: Image.asset("assets/images/shop4you.jpeg",
                          fit: BoxFit.cover, width: double.maxFinite),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //Name TextField
                          AppTextField(
                            icon: Icons.person_outlined,
                            type: TextInputType.text,
                            hintText: "Name",
                            controller: nameController,
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
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
                          //Phone TextField
                          AppTextField(
                            icon: Icons.phone_outlined,
                            type: TextInputType.number,
                            hintText: "Phone",
                            controller: phoneController,
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          //Password TextField

                          AppTextField(
                            icon: Icons.password_outlined,
                            type: TextInputType.text,
                            hintText: "Enter your Password",
                            controller: passwordController,
                          ),
                          SizedBox(
                            height:
                                Dimensions.height20 + Dimensions.height20 / 2,
                          ),
                          GestureDetector(
                            onTap: () {
                              _registration(authController);
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
                                "Sign up",
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
                                text: "Already have an account,",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimensions.font16),
                                children: [
                                  TextSpan(
                                    //TODO: Change this to appropreate page
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Get.back(),
                                    text: " Sign In?",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.font16),
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                ])
              : const Center(
                  child: CustomLoader(),
                );
        },
      ),
    );
  }
}
