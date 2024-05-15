import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tengerine/Services/FirebaseDatabaseHelper.dart';
import '../../../Objects/CutomerObject.dart';
import '../../../Services/FirebaseStorageService.dart';

import '../Firebase/FirebaseDatabaseService.dart';
import 'otp_verification_view.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
 

  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();

  @override
  void initState() {
    
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  


  @override
  Widget build(BuildContext context) {
 

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  bottom: 15, right: 15, left: 15, top: 120),
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Form(
                
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Get Started!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppThemeColor.pureBlackColor,
                          fontSize: 24,
                        ),
                      ),
                      const Text(
                        'Create an Account to continue.',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppThemeColor.dullFontColor1,
                          fontSize: Dimensions.fontSizeDefault,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text("Select Profile Display "),
                   
                      const SizedBox(
                        height: 10,
                      ),
                      _singleField(
                        onSaved: (email) {
                          setState(() {
                          
                          });
                        },
                        showPassword: false,
                        controller: emailController,
                        hintText: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                        icon: Icons.alternate_email,
                        password: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Email Address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                   
                      const SizedBox(
                        height: 10,
                      ),
                    
                 
                    
                      const SizedBox(
                        height: 10,
                      ),
                    
                      InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance.currentUser?.reload();
                          sentOtpOnEmail();
                    
                        },
                        child: AppButtons().button1(
                          labelSize: Dimensions.fontSizeExtraLarge,
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          buttonLoading: false,
                          label: 'Save',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              'Sign In Account',
                              style: TextStyle(
                                fontSize: Dimensions.fontSizeSmall,
                                fontWeight: FontWeight.w400,
                                color: AppThemeColor.dullFontColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
     
          ],
        ),
      ),
    );
  }

 

//TODO here is the text field
 
  Widget _singleField(
      {required void Function(String?)? onSaved,
      required String? Function(String?)? validator,
      String? Function(String?)? onChanged,
      required String hintText,
      Function? passFunction,
      required TextInputType keyboardType,
      required IconData icon,
      required bool password,
      required bool showPassword,
      TextEditingController? controller}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppThemeColor.lightGrayColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onSaved: onSaved,
              controller: controller,
              validator: validator,
              obscureText: password,
              keyboardType: keyboardType,
              onChanged: (data) {
                if (onChanged != null) {
                  onChanged!(data);
                }
              },
              decoration: InputDecorations.decoration1(
                hintText: hintText,
                labelText: null,
                icon: icon,
              ),
            ),
          ),
          if (passFunction != null)
            InkWell(
              onTap: () => passFunction(),
              child: Icon(
                showPassword ? Icons.visibility : Icons.visibility_off,
                size: 22,
                color: AppThemeColor.dullFontColor,
              ),
            ),
        ],
      ),
    );
  }

  //TODO here we have sent link on email
  Future<void> sentOtpOnEmail() async {
    if (emailController.text.isEmpty) {
      return;
    }
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailController.text, password: "")
          .then((customerValue) async {


        User? firebaseCurrentUser = FirebaseAuth.instance.currentUser;

        print("check comple ${firebaseCurrentUser?.toString()}");
        if (firebaseCurrentUser != null &&
            firebaseCurrentUser?.emailVerified == false) {
          await firebaseCurrentUser?.sendEmailVerification();

          ShowToast().showNormalToast(
              msg:
              "We have sent a verification mail on your email.Please verify using the link ");

          

          ;
        }
        setState(() {});
      });
    } catch (e) {
      ShowToast().showNormalToast(msg: '${e}');


    }
  }









}
