import 'package:flutter/material.dart';
import 'home_activity.dart';

class LoginActivityStatic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/loginbg.png', width: 200),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    'Welcome to the App',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    backgroundColor: const Color.fromARGB(255, 33, 1, 95),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40),)
                  ),
                  onPressed: () {
                    // Navigate to HomeActivity directly
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeActivity(mobileNumber: '7566880933')),
                    );
                  },
                  child: Text("Login", textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
