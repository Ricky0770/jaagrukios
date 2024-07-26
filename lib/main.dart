import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jagruk/firebase_options.dart';
import 'package:jagruk/home_activity.dart';
import 'package:jagruk/login_activity.dart';
import 'package:jagruk/otp_activity.dart';

Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginActivity());
}
