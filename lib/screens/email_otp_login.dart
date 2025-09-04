import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailOtpScreen extends StatefulWidget {
  const EmailOtpScreen({super.key});

  @override
  State<EmailOtpScreen> createState() => _EmailOtpScreenState();
}

class _EmailOtpScreenState extends State<EmailOtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  String _message = "";

  Future<void> _sendOtp() async {
    try {
      // This actually sends a sign-in link (Firebase email OTP way)
      await _auth.sendSignInLinkToEmail(
        email: _emailController.text.trim(),
        actionCodeSettings: ActionCodeSettings(
          url:
              "https://your-app.firebaseapp.com", // Change to your Firebase URL
          handleCodeInApp: true,
          iOSBundleId: "com.example.myApp",
          androidPackageName: "com.example.my_app",
          androidInstallApp: true,
          androidMinimumVersion: "21",
        ),
      );
      setState(() {
        _message = "OTP (link) sent! Check your email.";
      });
    } catch (e) {
      setState(() {
        _message = "Error: $e";
      });
    }
  }

  Future<void> _verifyOtp() async {
    try {
      final emailLink = _otpController.text.trim(); // Paste link from email
      if (_auth.isSignInWithEmailLink(emailLink)) {
        await _auth.signInWithEmailLink(
          email: _emailController.text.trim(),
          emailLink: emailLink,
        );
        setState(() {
          _message = "✅ Login successful!";
        });
      } else {
        setState(() {
          _message = "Invalid link/OTP.";
        });
      }
    } catch (e) {
      setState(() {
        _message = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Email OTP Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Enter Email"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _sendOtp, child: const Text("Send OTP")),
            const SizedBox(height: 20),
            TextField(
              controller: _otpController,
              decoration: const InputDecoration(
                labelText: "Paste OTP Link from Email",
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _verifyOtp,
              child: const Text("Verify OTP"),
            ),
            const SizedBox(height: 20),
            Text(_message, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
