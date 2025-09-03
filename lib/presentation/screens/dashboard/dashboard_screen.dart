import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:arch_approve/presentation/screens/apply_leaves/apply_leaves_screen.dart';
import 'package:arch_approve/presentation/screens/home/home_screen.dart';
import 'package:arch_approve/presentation/screens/leaves_history/history_screen.dart';
import 'package:arch_approve/presentation/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  final int initialIndex;
  const DashboardScreen({super.key, this.initialIndex = 0});

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
    LeaveHistoryScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.25)),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: kPrimaryColor,
              haptic: false,
              tabBorderRadius: 15,
              textStyle: Theme.of(context).textTheme.displayMedium,
              hoverColor: kLightPrimaryColor,
              gap: 8,
              activeColor: kWhiteColor,
              iconSize: 26,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),

              // tabActiveBorder: Border.all(), // not needed
              // tabBorder: Border.all(color: kLightPrimaryColor),
              tabBackgroundGradient: kLightPrimaryGradient,
              color: kDarkGreyColor,
              tabs: [
                GButton(icon: Icons.home, text: 'Home'),
                // GButton(icon: Icons.add, text: 'Apply Leave'),
                GButton(icon: Icons.inbox_outlined, text: 'Leaves'),
                GButton(icon: Icons.person, text: 'Profile'),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
