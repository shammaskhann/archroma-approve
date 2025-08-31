import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kWhiteColor,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: height * 0.3,
            width: width,
            decoration: BoxDecoration(
              gradient: kL,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: kBlackColor.withOpacity(0.3),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  "Home",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Avatar (person icon) and below "Welcome, back" next line "Adnan Ahmed"
                      SizedBox(height: 20),
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: kWhiteColor,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: kDarkGreyColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Welcome, back",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: kWhiteColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Adnan Ahmed",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: kWhiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
