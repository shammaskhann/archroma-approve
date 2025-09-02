import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:arch_approve/presentation/screens/apply_leaves/apply_leaves_screen.dart';
import 'package:arch_approve/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),

    //ApplyLeavesScreen(),
    Text('Search', style: optionStyle),
    Text('Profile', style: optionStyle),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: kLightPrimaryGradient,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.25)),
          ],
        ),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.transparent, // important!
          elevation: 0, // so shadow matches container
          onPressed: () {
            Get.toNamed(AppRoutesConstant.applyLeave, arguments: "");
          },
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: kWhiteColor),
              SizedBox(width: 5),
              Text(
                "Apply Leaves",
                style: TextStyle(
                  color: kWhiteColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),

      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.25)),
      //     ],
      //   ),
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      //       child: GNav(
      //         rippleColor: kPrimaryColor,
      //         haptic: false,
      //         tabBorderRadius: 15,
      //         textStyle: Theme.of(context).textTheme.displaySmall,
      //         hoverColor: kLightPrimaryColor,
      //         gap: 8,
      //         activeColor: kWhiteColor,
      //         iconSize: 24,
      //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      //         duration: Duration(milliseconds: 400),

      //         tabActiveBorder: Border.all(), // not needed
      //         // tabBorder: Border.all(color: kLightPrimaryColor),
      //         tabBackgroundGradient: kLightPrimaryGradient,
      //         color: kDarkGreyColor,
      //         tabs: [
      //           GButton(icon: Icons.home, text: 'Home'),
      //           // GButton(icon: Icons.add, text: 'Apply Leave'),
      //           GButton(icon: Icons.history, text: 'LeaveStatus'),
      //           GButton(icon: Icons.person, text: 'Profile'),
      //         ],
      //         selectedIndex: _selectedIndex,
      //         onTabChange: (index) {
      //           setState(() {
      //             _selectedIndex = index;
      //           });
      //         },
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
