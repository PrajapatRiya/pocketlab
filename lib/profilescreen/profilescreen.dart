import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  bool showSavedData = false;
  List<File> certificates = [];

  final List<Map<String, String>> paymentHistory = [
    {"date": "11-01-2022", "amount": "\$9.99", "status": "Success"},
    {"date": "24-11-2024", "amount": "\$9.99", "status": "Success"},
    {"date": "16-12-2025", "amount": "\$9.99", "status": "Failed"},
  ];

  // Image Picker Functions
  Future<void> _pickImage(ImageSource source) async {
    PermissionStatus status;
    if (Platform.isIOS) {
      status = source == ImageSource.camera
          ? await Permission.camera.request()
          : await Permission.photos.request();
    } else {
      status = source == ImageSource.camera
          ? await Permission.camera.request()
          : await Permission.photos.request();
      if (!status.isGranted) status = await Permission.storage.request();
    }

    if (status.isGranted) {
      final XFile? pickedFile = await _picker.pickImage(source: source, imageQuality: 80);
      if (pickedFile != null) {
        setState(() => _profileImage = File(pickedFile.path));
      }
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permission denied")),
      );
    }
  }

  void _showImageSourceChoice() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.white),
                title: const Text('Gallery', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.white),
                title: const Text('Camera', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickCertificate() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (pickedFile != null) {
      setState(() => certificates.add(File(pickedFile.path)));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Certificate added!")),
      );
    }
  }

  void _removeCertificate(int index) {
    setState(() => certificates.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Certificate removed")),
    );
  }

  // LOGOUT FUNCTION WITH CONFIRMATION
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text("Logout", style: TextStyle(color: Colors.white)),
        content: const Text("Are you sure you want to logout?", style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // Close dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Logged out successfully!"),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              // Ya phir: Navigator.popUntil(context, ModalRoute.withName('/home'));
            },
            child: const Text("Logout", style: TextStyle(color:Color(0xFF0D47A1) )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(), // Now includes Logout button
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      _buildProfilePhoto(screenWidth),
                      SizedBox(height: screenHeight * 0.03),

                      showSavedData ? _displaySavedData() : _buildInputFields(screenHeight),

                      SizedBox(height: screenHeight * 0.04),
                      _saveBtn(screenWidth, screenHeight),
                      SizedBox(height: screenHeight * 0.04),

                      _subscriptionStatus(screenHeight, screenWidth),
                      SizedBox(height: screenHeight * 0.03),

                      _paymentHistory(screenHeight, screenWidth),
                      SizedBox(height: screenHeight * 0.04),

                      _certificatesSection(screenHeight, screenWidth),

                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 100),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // APPBAR WITH LOGOUT BUTTON
  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          const Text(
            "Edit Profile",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Spacer(),

          // LOGOUT BUTTON
          IconButton(
            onPressed: _showLogoutDialog,
            icon: const Icon(Icons.logout, color: Color(0xFF0D47A1), size: 28),
            tooltip: "Logout",
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePhoto(double screenWidth) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: screenWidth * 0.16,
            backgroundColor: Colors.grey[800],
            backgroundImage: _profileImage != null
                ? FileImage(_profileImage!)
                : const AssetImage("assets/images/profile1.jpg") as ImageProvider,
          ),
          Positioned(
            right: 6,
            bottom: 6,
            child: GestureDetector(
              onTap: _showImageSourceChoice,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade900,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputFields(double h) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label("Full Name"),
        _inputField(nameCtrl, "Enter your name"),
        SizedBox(height: h * 0.02),
        _label("Email"),
        _inputField(emailCtrl, "Enter your email"),
        SizedBox(height: h * 0.02),
        _label("Phone Number"),
        _inputField(phoneCtrl, "Enter mobile number"),
      ],
    );
  }

  Widget _displaySavedData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoRow("Full Name", nameCtrl.text),
        _infoRow("Email", emailCtrl.text),
        _infoRow("Phone Number", phoneCtrl.text),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _saveBtn(double w, double h) {
    return SizedBox(
      width: w * 0.9,
      height: h * 0.065,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade900,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 10,
        ),
        onPressed: () {
          if (nameCtrl.text.isNotEmpty && emailCtrl.text.isNotEmpty && phoneCtrl.text.isNotEmpty) {
            setState(() => showSavedData = true);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile saved successfully!")),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please fill all fields")),
            );
          }
        },
        child: const Text("Save Changes", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget _subscriptionStatus(double h, double w) {
    return Card(
      color: Colors.blue.shade900.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: h * 0.02, horizontal: w * 0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Subscription Status", style: TextStyle(color: Colors.white70, fontSize: 14)),
                SizedBox(height: 5),
                Text("Active", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
              child: const Text("Renew", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentHistory(double h, double w) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Payment History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: h * 0.02),
        ...paymentHistory.map((p) {
          bool success = p['status'] == "Success";
          return Card(
            color: Colors.grey[900],
            margin: EdgeInsets.symmetric(vertical: h * 0.008),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: success ? Colors.green : Colors.red,
                child: Icon(success ? Icons.check : Icons.close, color: Colors.white),
              ),
              title: Text(p['date']!, style: const TextStyle(color: Colors.white)),
              subtitle: Text(p['status']!, style: TextStyle(color: success ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
              trailing: Text(p['amount']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          );
        }),
      ],
    );
  }

  Widget _certificatesSection(double h, double w) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Certificates & Achievements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            GestureDetector(
              onTap: _pickCertificate,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(color: Colors.blue.shade900, borderRadius: BorderRadius.circular(30)),
                child: const Row(children: [
                  Icon(Icons.add, color: Colors.white),
                  SizedBox(width: 6),
                  Text("Add", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                ]),
              ),
            ),
          ],
        ),
        SizedBox(height: h * 0.02),
        certificates.isEmpty
            ? Container(
          width: double.infinity,
          padding: EdgeInsets.all(h * 0.06),
          decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white12)),
          child: Column(
            children: [
              Icon(Icons.emoji_events_outlined, size: 70, color: Colors.amber[700]),
              const SizedBox(height: 16),
              const Text("No certificates yet", style: TextStyle(color: Colors.white70, fontSize: 16)),
              const Text("Add your achievements!", style: TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
        )
            : GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1),
          itemCount: certificates.length,
          itemBuilder: (ctx, i) => Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.file(certificates[i], fit: BoxFit.cover, width: double.infinity, height: double.infinity)),
              Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                      onTap: () => _removeCertificate(i),
                      child: const CircleAvatar(radius: 14, backgroundColor: Colors.red, child: Icon(Icons.close, size: 18, color: Colors.white)))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(left: 4, bottom: 8),
    child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 15)),
  );

  Widget _inputField(TextEditingController c, String hint) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
        color: const Color(0xFF2A2A3D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24)),
    child: TextField(
      controller: c,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(color: Colors.white54), border: InputBorder.none),
    ),
  );
}