import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocketlab/loginsignupscreen/login_signupscreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameCtrl = TextEditingController(text: "Sophia");
  final TextEditingController emailCtrl = TextEditingController(text: "sophia@example.com");
  final TextEditingController phoneCtrl = TextEditingController(text: "+1 234 567 890");

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  bool showSavedData = false;
  List<File> certificates = [];

  final List<Map<String, String>> paymentHistory = [
    {"date": "11 Jan 2024", "amount": "\$9.99", "status": "Success"},
    {"date": "24 Nov 2023", "amount": "\$9.99", "status": "Success"},
    {"date": "16 Dec 2022", "amount": "\$9.99", "status": "Failed"},
  ];

  // Pick Profile Image
  Future<void> _pickImage(ImageSource source) async {
    PermissionStatus status = source == ImageSource.camera
        ? await Permission.camera.request()
        : await Permission.photos.request();

    if (status.isGranted || status.isLimited) {
      final XFile? pickedFile = await _picker.pickImage(source: source, imageQuality: 80);
      if (pickedFile != null) {
        setState(() => _profileImage = File(pickedFile.path));
      }
    } else {
      openAppSettings();
    }
  }

  // Pick Certificate Image - Direct Gallery Access
  Future<void> _pickCertificate() async {
    // Request permission first for safety
    PermissionStatus status = await Permission.photos.request();
    
    if (status.isGranted || status.isLimited) {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
      if (pickedFile != null) {
        setState(() => certificates.add(File(pickedFile.path)));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Certificate added successfully!"), backgroundColor: Colors.green),
        );
      }
    } else {
      openAppSettings();
    }
  }

  // Logout Function
  void _logout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1B1B2F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: const Text("Logout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text("Are you sure you want to logout?", style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel", style: TextStyle(color: Colors.white38)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              Navigator.pop(ctx); // Close dialog
              // Clear navigation stack and go to Login screen
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginSignupScreen()),
                (route) => false,
              );
            },
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showImageSourceChoice() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Profile Photo", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _sourceOption(Icons.photo_library_rounded, "Gallery", () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  }),
                  _sourceOption(Icons.camera_alt_rounded, "Camera", () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  }),
                ],
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sourceOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28.sp),
          ),
          SizedBox(height: 10.h),
          Text(label, style: TextStyle(color: Colors.white70, fontSize: 14.sp, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: _buildBlurCircle(Theme.of(context).colorScheme.primary.withOpacity(0.12), 250),
          ),
          Positioned(
            bottom: 100,
            left: -50,
            child: _buildBlurCircle(Theme.of(context).colorScheme.secondary.withOpacity(0.08), 200),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 100.h),
              child: Column(
                children: [
                  _buildAppBar(),
                  SizedBox(height: 30.h),
                  _buildProfilePhoto(),
                  SizedBox(height: 40.h),
                  _buildInputFields(),
                  SizedBox(height: 40.h),
                  _buildSubscriptionCard(),
                  SizedBox(height: 40.h),
                  _buildPaymentHistory(),
                  SizedBox(height: 40.h),
                  _buildCertificatesSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: color, blurRadius: 100, spreadRadius: 50)],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18.sp),
          ),
        ),
        Text("Profile Settings", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -0.5)),
        GestureDetector(
          onTap: _logout, // Logout function linked here
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.redAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.logout_rounded, color: Colors.redAccent, size: 18.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePhoto() {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
            ),
            child: CircleAvatar(
              radius: 65.r,
              backgroundColor: Colors.white.withOpacity(0.05),
              backgroundImage: _profileImage != null
                  ? FileImage(_profileImage!)
                  : const AssetImage("assets/images/profile1.jpg") as ImageProvider,
            ),
          ),
          Positioned(
            right: 4,
            bottom: 4,
            child: GestureDetector(
              onTap: _showImageSourceChoice,
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                  ),
                  boxShadow: [
                    BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))
                  ],
                ),
                child: Icon(Icons.edit_rounded, color: Colors.white, size: 18.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        _profileTextField("Full Name", nameCtrl, Icons.person_outline_rounded),
        SizedBox(height: 20.h),
        _profileTextField("Email Address", emailCtrl, Icons.email_outlined),
        SizedBox(height: 20.h),
        _profileTextField("Phone Number", phoneCtrl, Icons.phone_android_rounded),
      ],
    );
  }

  Widget _profileTextField(String label, TextEditingController controller, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white54, fontSize: 13.sp, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20.sp),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriptionCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF1E3C72), const Color(0xFF2A5298)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(color: const Color(0xFF1E3C72).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Pocket Lab Pro", style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w900)),
                SizedBox(height: 6.h),
                Text("Expires on 12 Dec 2024", style: TextStyle(color: Colors.white70, fontSize: 13.sp, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text("Renew", style: TextStyle(color: const Color(0xFF1E3C72), fontWeight: FontWeight.w900, fontSize: 13.sp)),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payment History", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
        SizedBox(height: 20.h),
        ...paymentHistory.map((p) => Container(
          margin: EdgeInsets.only(bottom: 15.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: (p['status'] == "Success" ? Colors.green : Colors.red).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  p['status'] == "Success" ? Icons.check_rounded : Icons.close_rounded,
                  color: p['status'] == "Success" ? Colors.green : Colors.red,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p['date']!, style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 2.h),
                    Text(p['status']!, style: TextStyle(color: Colors.white38, fontSize: 12.sp, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Text(p['amount']!, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w900)),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildCertificatesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Certificates", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
            GestureDetector(
              onTap: _pickCertificate,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
                ),
                child: Text("Add New", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 13.sp, fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        certificates.isEmpty && paymentHistory.isEmpty // Just a condition for mock
          ? _buildEmptyCertificates()
          : SizedBox(
              height: 120.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: certificates.length + 3, // Mock + Real
                itemBuilder: (context, index) {
                  if (index < 3) {
                    return _certificateItem(index == 0 ? "UI/UX Master" : index == 1 ? "Flutter Expert" : "Python Advanced");
                  }
                  return _certificateImageItem(certificates[index - 3]);
                },
              ),
            )
      ],
    );
  }

  Widget _buildEmptyCertificates() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Icon(Icons.workspace_premium_rounded, color: Colors.white12, size: 50.sp),
          SizedBox(height: 10.h),
          Text("No certificates yet", style: TextStyle(color: Colors.white30, fontSize: 14.sp, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _certificateItem(String title) {
    return Container(
      width: 150.w,
      margin: EdgeInsets.only(right: 15.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(color: Colors.amber.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(Icons.workspace_premium_rounded, color: Colors.amber, size: 28.sp),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(title, 
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white70, fontSize: 12.sp, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _certificateImageItem(File file) {
    return Container(
      width: 150.w,
      margin: EdgeInsets.only(right: 15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.r),
        child: Image.file(file, fit: BoxFit.cover),
      ),
    );
  }
}
