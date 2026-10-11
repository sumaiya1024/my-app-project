import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Color primaryTeal = const Color(0xFF0F766E);
  final Color lightTeal = const Color(0xFF14B8A6);
  final Color backgroundColor = const Color(0xFFF4F7FA);

  // প্রোফাইল লক/আনলক স্টেট (ডিফল্টভাবে লক থাকবে)
  bool _isProfileLocked = true;

  // টেক্সট কন্ট্রোলারসমূহ
  final TextEditingController _nameController = TextEditingController(
    text: "Sumaiya Shahara",
  );
  final TextEditingController _phoneController = TextEditingController(
    text: "+880 1531984845",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "sumaiyashahara@gmail.com",
  );
  final TextEditingController _addressController = TextEditingController(
    text: "Gulshan-2, Dhaka, Bangladesh",
  );
  final TextEditingController _emergencyContactController =
      TextEditingController(text: "+880 1812345678");
  final TextEditingController _bioController = TextEditingController(
    text:
        "Professional Care Ambassador with 3+ years of experience in elderly and patient care.",
  );

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _emergencyContactController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  // আনলক করার ডায়ালগ দেখানোর ফাংশন
  void _showUnlockDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.lock_open_rounded, color: primaryTeal, size: 28),
            const SizedBox(width: 8),
            const Text("Unlock Profile?"),
          ],
        ),
        content: const Text(
          "Your profile is currently locked for security. Do you want to unlock it to edit your details?",
          style: TextStyle(color: Colors.black87, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryTeal,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              setState(() {
                _isProfileLocked = false; // আনলক হয়ে গেল
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Profile unlocked! You can now edit your details.",
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              "Yes, Unlock",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // সেভ করার ফাংশন (সেভ করলে আবার লক হয়ে যাবে)
  void _saveProfile() {
    setState(() {
      _isProfileLocked = true; // সেভ করার পর আবার লক করে দেওয়া হলো
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile updated and locked successfully!"),
        backgroundColor: Colors.teal,
      ),
    );
  }

  // প্রোফাইল পিকচার চেঞ্জ করার বটম শিট বা অপশন
  void _showImageOptions() {
    if (_isProfileLocked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please unlock your profile first to change photo."),
        ),
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Profile Photo",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: Icon(Icons.camera_alt, color: primaryTeal),
                title: const Text("Take a Photo"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Camera opened")),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: primaryTeal),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Gallery opened")),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: primaryTeal,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // অ্যাপবারের লক/আনলক স্ট্যাটাস বাটন
          IconButton(
            icon: Icon(
              _isProfileLocked ? Icons.lock_rounded : Icons.lock_open_rounded,
              color: _isProfileLocked ? Colors.amberAccent : Colors.white,
            ),
            tooltip: _isProfileLocked
                ? "Profile is Locked"
                : "Profile is Unlocked",
            onPressed: () {
              if (_isProfileLocked) {
                _showUnlockDialog();
              } else {
                setState(() {
                  _isProfileLocked = true; // চাইলে ম্যানুয়ালি আবার লক করা যাবে
                });
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // প্রোফাইল পিকচার সেকশন
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: lightTeal.withValues(alpha: 0.2),
                    child: Text(
                      _nameController.text.isNotEmpty
                          ? _nameController.text[0]
                          : "S",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: primaryTeal,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _showImageOptions,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: primaryTeal,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ১. স্ট্যাটাস ব্যানার (লক নাকি আনলক তা বোঝানোর জন্য)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isProfileLocked
                    ? Colors.amber.shade50
                    : Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isProfileLocked ? Colors.amber.shade300 : lightTeal,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _isProfileLocked
                        ? Icons.lock_outline
                        : Icons.lock_open_outlined,
                    color: _isProfileLocked
                        ? Colors.amber.shade800
                        : primaryTeal,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isProfileLocked
                              ? "Profile is Locked"
                              : "Profile is Unlocked for Editing",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: _isProfileLocked
                                ? Colors.amber.shade900
                                : primaryTeal,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _isProfileLocked
                              ? "Tap the lock icon above or click unlock to edit your info."
                              : "Make your changes and tap save below.",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_isProfileLocked)
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        minimumSize: Size.zero,
                      ),
                      onPressed: _showUnlockDialog,
                      child: const Text(
                        "Unlock",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ২. প্রোফাইল ইনফো ফিল্ডসমূহ
            const Text(
              "Personal Information",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            _buildTextField(
              controller: _nameController,
              label: "Full Name",
              icon: Icons.person_outline,
              enabled: !_isProfileLocked,
            ),
            const SizedBox(height: 14),

            _buildTextField(
              controller: _phoneController,
              label: "Phone Number",
              icon: Icons.phone_outlined,
              enabled: !_isProfileLocked,
            ),
            const SizedBox(height: 14),

            _buildTextField(
              controller: _emailController,
              label: "Email Address",
              icon: Icons.email_outlined,
              enabled: !_isProfileLocked,
            ),
            const SizedBox(height: 14),

            _buildTextField(
              controller: _emergencyContactController,
              label: "Emergency Contact",
              icon: Icons.contact_phone_outlined,
              enabled: !_isProfileLocked,
            ),
            const SizedBox(height: 14),

            _buildTextField(
              controller: _addressController,
              label: "Address",
              icon: Icons.location_on_outlined,
              enabled: !_isProfileLocked,
              maxLines: 2,
            ),
            const SizedBox(height: 14),

            _buildTextField(
              controller: _bioController,
              label: "Professional Bio / Experience",
              icon: Icons.info_outline,
              enabled: !_isProfileLocked,
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // ৩. সেভ বাটন (প্রোফাইল আনলক থাকলেই শুধু দৃশ্যমান হবে)
            if (!_isProfileLocked)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryTeal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _saveProfile,
                  icon: const Icon(Icons.save_rounded),
                  label: const Text(
                    "Save & Lock Profile",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // কাস্টম টেক্সট ফিল্ড উইজেট
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool enabled,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      style: TextStyle(
        color: enabled ? Colors.black87 : Colors.grey.shade700,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: enabled ? primaryTeal : Colors.grey),
        filled: true,
        fillColor: enabled
            ? Colors.white
            : Colors.grey.shade200, // লক থাকলে ব্যাকগ্রাউন্ড গ্রে দেখাবে
        prefixIcon: Icon(icon, color: enabled ? primaryTeal : Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: lightTeal.withValues(alpha: 0.15)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: lightTeal.withValues(alpha: 0.15)),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryTeal, width: 2),
        ),
      ),
    );
  }
}
