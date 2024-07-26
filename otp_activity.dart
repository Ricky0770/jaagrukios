import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class OTPActivity extends StatefulWidget {
  final String verificationId;

  OTPActivity({super.key, required this.verificationId});

  @override
  State<OTPActivity> createState() {
    return _OTPActivityState();
  }
}

class _OTPActivityState extends State<OTPActivity> {
  String otpCode = '';

  @override
  Widget build(context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/loginbg.png', width: 200,),
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
                      verificationId: widget.verificationId,
                      smsCode: otpCode
                    );
                    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                      print("Welcome User");
                    });
                  } catch (ex) {
                    print('Error verifying OTP: ${ex.toString()}');
                  }
                },
                child: Text("Verify OTP", textAlign: TextAlign.center,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
