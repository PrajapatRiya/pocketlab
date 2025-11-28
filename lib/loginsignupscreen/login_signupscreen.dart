import 'package:flutter/material.dart';
import 'package:pocketlab/Forgotpasswordscreen/Forgotpasswordscreen.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    // 📱 Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.07,
            vertical: screenHeight * 0.05,
          ),
          child: Container(
            width: screenWidth * 0.9,
            padding: EdgeInsets.all(screenWidth * 0.06),
            decoration: BoxDecoration(
              color: const Color(0xFF1B1B2F),
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: screenWidth * 0.03,
                  offset: Offset(0, screenWidth * 0.015),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Get Started",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.007),
                Text(
                  "Join our community of learners",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: screenWidth * 0.035,
                  ),
                ),
                SizedBox(height: screenHeight * 0.035),

                // 🔘 Toggle buttons (Register / Login)
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E2E48),
                    borderRadius: BorderRadius.circular(screenWidth * 0.08),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isLogin = false),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.012),
                            decoration: BoxDecoration(
                              color: !isLogin
                                  ? const Color(0xFF7B5FFF)
                                  : Colors.transparent,
                              borderRadius:
                              BorderRadius.circular(screenWidth * 0.08),
                            ),
                            child: const Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isLogin = true),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.012),
                            decoration: BoxDecoration(
                              color: isLogin
                                  ? const Color(0xFF7B5FFF)
                                  : Colors.transparent,
                              borderRadius:
                              BorderRadius.circular(screenWidth * 0.08),
                            ),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // ✉ Email field
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF2E2E48),
                    hintText: "Email or Phone",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon:
                    const Icon(Icons.email_outlined, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(screenWidth * 0.03),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // 🔒 Password field
                TextField(
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF2E2E48),
                    hintText: "Password",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon:
                    const Icon(Icons.lock_outline, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(screenWidth * 0.03),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                // 🔑 Forgot Password (only for Login)
                if (isLogin)
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: screenHeight * 0.01),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),


                SizedBox(height: screenHeight * 0.025),

                // 🚀 Main Button
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.065,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7B5FFF),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(screenWidth * 0.04),
                      ),
                    ),
                    child: Text(
                      isLogin ? "Login" : "Create Account",
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                // ➖ Divider with "Or continue with"
                Row(
                  children: [
                    Expanded(
                        child:
                        Container(height: 1, color: Colors.grey.shade800)),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ),
                    Expanded(
                        child:
                        Container(height: 1, color: Colors.grey.shade800)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

                // 🌐 Google Button
                OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF2E2E48)),
                    backgroundColor: const Color(0xFF2E2E48),
                    minimumSize: Size(double.infinity, screenHeight * 0.06),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(screenWidth * 0.03),
                    ),
                  ),
                  icon: Image.asset(
                    'assets/images/google.png',
                    height: screenWidth * 0.05,
                    width: screenWidth * 0.05,
                  ),
                  label: Text(
                    "Google",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                // 📜 Terms text
                Text(
                  "By continuing, you agree to our Terms of Service and Privacy Policy.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: screenWidth * 0.03,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
