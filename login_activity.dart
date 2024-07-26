import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'home_activity.dart';

class LoginActivity extends StatefulWidget {
  @override
  State<LoginActivity> createState() {
    return _LoginActivityState();
  }
}

class _LoginActivityState extends State<LoginActivity> {
  TextEditingController phoneController = TextEditingController();
  String verificationId = '';
  bool otpSent = false;
  String otpCode = '';
  bool isLoading = false; // Track loading state

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/loginbg.png', width: 200,),
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your mobile number',
                      suffixIcon: Icon(Icons.phone)
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    backgroundColor: const Color.fromARGB(255, 33, 1, 95),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40),)
                  ),
                  onPressed: isLoading ? null : () async {
                    setState(() {
                      isLoading = true; // Show progress indicator
                    });

                    String phoneNumber = phoneController.text.toString();
                    print('Sending OTP to $phoneNumber');
                    
                    FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: phoneNumber,
                      verificationCompleted: (PhoneAuthCredential credential) {
                        print('Verification completed automatically.');
                      },
                      verificationFailed: (FirebaseAuthException ex) {
                        setState(() {
                          isLoading = false; // Dismiss progress indicator
                        });
                        print('Failed to verify phone number: ${ex.message}');
                      },
                      codeSent: (String verificationId, int? resendToken) {
                        setState(() {
                          isLoading = false; // Dismiss progress indicator
                          this.verificationId = verificationId;
                          otpSent = true;
                        });
                        print('OTP sent to $phoneNumber');
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {
                        setState(() {
                          isLoading = false; // Dismiss progress indicator
                        });
                        print('Code auto retrieval timeout for $phoneNumber');
                      }
                    );
                  },
                  child: isLoading
                      ? CircularProgressIndicator() // Show progress indicator
                      : Text("Send OTP", textAlign: TextAlign.center,),
                ),
                if (otpSent) ...[
                  Container(
                    margin: EdgeInsets.all(20),
                    child: PinCodeFields(
                      length: 6,
                      fieldBorderStyle: FieldBorderStyle.square,
                      responsive: false,
                      fieldHeight: 50.0,
                      fieldWidth: 40.0,
                      borderWidth: 1.0,
                      activeBorderColor: Colors.blue,
                      activeBackgroundColor: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10.0),
                      keyboardType: TextInputType.number,
                      autoHideKeyboard: true,
                      fieldBackgroundColor: Colors.black12,
                      borderColor: Colors.blue,
                      textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      onComplete: (output) {
                        setState(() {
                          otpCode = output;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      backgroundColor: const Color.fromARGB(255, 33, 1, 95),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40),)
                    ),
                    onPressed: () async {
                      try {
                        print('Verifying OTP: $otpCode');
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: otpCode
                        );
                        await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                          print("Welcome User");
                          // Navigate to HomeActivity and pass mobile number as argument
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomeActivity(mobileNumber: phoneController.text)),
                          );
                        });
                      } catch (ex) {
                        print('Error verifying OTP: ${ex.toString()}');
                      }
                    },
                    child: Text("Verify OTP", textAlign: TextAlign.center,),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
