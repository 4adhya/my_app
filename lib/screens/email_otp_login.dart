import 'dart:math';
import 'package:flutter/material.dart';
import 'test_screen.dart'; // Make sure this exists

class EmailOTPLogin extends StatefulWidget {
  const EmailOTPLogin({super.key});

  @override
  State<EmailOTPLogin> createState() => _EmailOTPLoginState();
}

class _EmailOTPLoginState extends State<EmailOTPLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String? generatedOTP;
  bool otpSent = false;

  void sendOTP() {
    generatedOTP = (Random().nextInt(900000) + 100000).toString();
    setState(() {
      otpSent = true;
    });
    print("OTP for ${emailController.text}: $generatedOTP");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("OTP sent to your email (mock)")),
    );
  }

  void verifyOTP() {
    if (otpController.text == generatedOTP) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("✅ Login Successful")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TestScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("❌ Invalid OTP")));
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
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email Address"),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: sendOTP, child: const Text("Send OTP")),
            if (otpSent) ...[
              const SizedBox(height: 20),
              TextField(
                controller: otpController,
                decoration: const InputDecoration(labelText: "Enter OTP"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: verifyOTP,
                child: const Text("Verify OTP"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
