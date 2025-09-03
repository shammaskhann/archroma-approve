import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:arch_approve/core/services/shared_pref/local_Storage_service.dart';
import 'package:arch_approve/presentation/components/custom_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGreyColor,
      body: Column(
        children: [
          _buildWelcomeSection(context),
          const SizedBox(height: 20),
          _buildProfileOptionTiles(context),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.28,
      width: width,
      decoration: BoxDecoration(
        gradient: kL,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: kBlackColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: const Icon(Icons.logout, color: Colors.transparent),
            ),
          ),
          const CircleAvatar(
            radius: 40,
            backgroundColor: kWhiteColor,
            child: Icon(Icons.person, size: 50, color: kDarkGreyColor),
          ),
          const SizedBox(height: 10),
          const Text(
            "Welcome, back",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: kWhiteColor,
            ),
          ),
          const SizedBox(height: 5),
          FutureBuilder(
            future: UserPref.getName(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return DotsLoader(kWhiteColor);
              }
              return Text(
                snapshot.data ?? "User",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: kWhiteColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOptionTiles(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildTile(
            icon: Icons.person_outline,
            title: "Update Profile",
            onTap: () {
              Get.toNamed(AppRoutesConstant.updateProfile);
            },
          ),
          _buildTile(
            icon: Icons.lock_outline,
            title: "Change Password",
            onTap: () {
              Get.toNamed(AppRoutesConstant.changePassword);
            },
          ),
          _buildTile(
            icon: Icons.description_outlined,
            title: "Terms & Conditions",
            onTap: () {
              Get.toNamed(AppRoutesConstant.terms);
            },
          ),
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton.icon(
              onPressed: () async {
                final auth = FirebaseAuth.instance;
                await UserPref.clearData();
                await auth.signOut();
                Get.offAllNamed(AppRoutesConstant.login);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.logout),
              label: const Text("Logout", style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Colors.blue.shade700),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
