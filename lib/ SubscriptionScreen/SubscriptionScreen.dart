// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Stripe Initialization
    Stripe.publishableKey = "pk_test_51XXXXXX"; // <-- YOUR STRIPE PUBLISHABLE KEY
    Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
    Stripe.instance.applySettings();
  }

  // ---------------- STRIPE PAYMENT ----------------
  Future<void> startPayment(String name, String plan, int amount) async {
    try {
      // ---- 1. Create PaymentIntent on Backend ----
      final paymentIntent = await createPaymentIntent(amount.toString(), "INR");

      if (paymentIntent == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Payment failed")));
        return;
      }

      // ---- 2. Initialize Payment Sheet ----
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: name,
        ),
      );

      // ---- 3. Display Payment Sheet ----
      await Stripe.instance.presentPaymentSheet();

      // ---- 4. Success ----
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$plan Purchased Successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Payment Failed: $e")));
    }
  }

  // ---------------- CREATE PAYMENT INTENT ----------------
  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      // Convert Rs → Paise
      final int amountInPaise = int.parse(amount) * 100;

      // ⚠️ You MUST replace URL with your backend API
      var url = Uri.parse("https://your-backend.com/create-payment-intent");

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "amount": amountInPaise,
          "currency": currency,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      print("Error creating payment intent: $e");
      return null;
    }
  }

  // ---------------- UI START ----------------
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            headerUI(screenHeight, screenWidth),
            SizedBox(height: screenHeight * 0.02),
            nameFieldUI(screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.02),

            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                children: [
                  buildPlanCard(
                    screenHeight,
                    screenWidth,
                    title: "Basic Plan",
                    price: "₹199 / month",
                    duration: "30 Days",
                    amount: 199,
                    color: Colors.blue.shade50,
                    borderColor: Colors.blue,
                    benefits: [
                      "Access to basic courses",
                      "PDF study materials",
                      "Basic certificate",
                    ],
                  ),
                  SizedBox(height: 16),

                  buildPlanCard(
                    screenHeight,
                    screenWidth,
                    title: "Standard Plan",
                    price: "₹399 / month",
                    duration: "30 Days",
                    amount: 399,
                    color: Colors.green.shade50,
                    borderColor: Colors.green,
                    benefits: [
                      "All basic features",
                      "Live doubt classes",
                      "Completion certificate",
                      "Offline video downloads",
                    ],
                  ),
                  SizedBox(height: 16),

                  buildPlanCard(
                    screenHeight,
                    screenWidth,
                    title: "Premium Plan",
                    price: "₹699 / month",
                    duration: "30 Days",
                    amount: 699,
                    color: Colors.amber.shade50,
                    borderColor: Colors.amber,
                    benefits: [
                      "All standard features",
                      "1-on-1 mentorship",
                      "Premium certificate",
                      "Priority support",
                      "Private community group",
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget headerUI(double h, double w) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: h * 0.03),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text("Subscription Plans",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.07,
                  fontWeight: FontWeight.bold)),
          Text("Upgrade your learning experience",
              style: TextStyle(color: Colors.white70, fontSize: w * 0.045)),
        ],
      ),
    );
  }

  // ---------------- NAME FIELD ----------------
  Widget nameFieldUI(double w, double h) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.05),
      child: TextField(
        controller: nameController,
        decoration: InputDecoration(
          hintText: "Enter your name",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // ---------------- PLAN CARD ----------------
  Widget buildPlanCard(
      double h,
      double w, {
        required String title,
        required String price,
        required String duration,
        required int amount,
        required Color color,
        required Color borderColor,
        required List<String> benefits,
      }) {
    return Container(
      padding: EdgeInsets.all(w * 0.05),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: w * 0.055,
                  color: Colors.black)),

          SizedBox(height: 6),

          Text(price,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: w * 0.045,
                  color: Colors.black87)),

          SizedBox(height: 8),

          Row(
            children: [
              Icon(Icons.access_time, color: Colors.deepPurple),
              SizedBox(width: 10),
              Text("Duration: $duration",
                  style: TextStyle(
                      fontSize: w * 0.04, fontWeight: FontWeight.w500)),
            ],
          ),

          SizedBox(height: 12),

          Column(
            children: benefits.map((b) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(b,
                          style: TextStyle(
                              fontSize: w * 0.04,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 16),

          // SUBSCRIBE BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: borderColor,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                final name = nameController.text.trim();

                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter your name")),
                  );
                  return;
                }

                startPayment(name, title, amount);
              },
              child: Text("Subscribe Now",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
