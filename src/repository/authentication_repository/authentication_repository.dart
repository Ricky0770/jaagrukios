import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AuthenticationRepository extends GetxController
{
  static AuthenticationRepository get instance => Get.find();
  //variables
  final auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  @override
  void onReady() {
    // firebaseUser = Rx<User>(_auth.currentu)
    // TODO: implement onReady
    super.onReady();
  }
}