import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketlab/Forgotpasswordscreen/Forgotpasswordscreen.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or Icon Placeholder
              Container(
                height: 80.h,
                width: 80.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                  ),
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Icon(Icons.rocket_launch, color: Colors.white, size: 40.sp),
              ),
              SizedBox(height: 30.h),
              Text(
                isLogin ? "Welcome Back" : "Create Account",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                isLogin ? "Login to continue your learning journey" : "Join our community of learners today",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 40.h),

              // Toggle Register/Login
              Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Row(
                  children: [
                    _buildToggleButton("Login", isLogin, () => setState(() => isLogin = true)),
                    _buildToggleButton("Register", !isLogin, () => setState(() => isLogin = false)),
                  ],
                ),
              ),
              SizedBox(height: 30.h),

              // Input Fields
              _buildTextField(
                hint: "Email or Phone",
                icon: Icons.email_outlined,
              ),
              SizedBox(height: 16.h),
              _buildTextField(
                hint: "Password",
                icon: Icons.lock_outline,
                isPassword: true,
              ),

              if (isLogin)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),

              SizedBox(height: isLogin ? 20.h : 30.h),

              // Main Button
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                  ),
                  child: Text(
                    isLogin ? "Login" : "Create Account",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              Row(
                children: [
                  Expanded(child: Divider(color: Colors.white.withOpacity(0.1))),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      "Or continue with",
                      style: TextStyle(color: Colors.white38, fontSize: 12.sp),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.white.withOpacity(0.1))),
                ],
              ),

              SizedBox(height: 24.h),

              // Social Button
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white.withOpacity(0.1)),
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                  backgroundColor: Colors.white.withOpacity(0.02),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/google.png', height: 20.h),
                    SizedBox(width: 12.w),
                    Text(
                      "Continue with Google",
                      style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),
              Text(
                "By continuing, you agree to our Terms of Service\nand Privacy Policy.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 11.sp,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String title, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: active ? Theme.of(context).colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: active ? Colors.white : Colors.white54,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint, required IconData icon, bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: TextField(
        obscureText: isPassword,
        style: TextStyle(color: Colors.white, fontSize: 15.sp),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white38, fontSize: 14.sp),
          prefixIcon: Icon(icon, color: Colors.white38, size: 20.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        ),
      ),
    );
  }
}
