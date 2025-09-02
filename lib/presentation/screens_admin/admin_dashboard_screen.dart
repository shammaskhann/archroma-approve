import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:arch_approve/presentation/screens_admin/pages/admin_calendar_screen.dart';
import 'package:arch_approve/presentation/screens_admin/pages/admin_employees_screen.dart';
import 'package:arch_approve/presentation/screens_admin/pages/admin_requests_screen.dart';
import 'package:arch_approve/presentation/screens_admin/pages/admin_stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    AdminRequestsScreen(),
    AdminEmployeesScreen(),
    AdminStatsScreen(),
    AdminCalendarScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: _pages[_selectedIndex],

      // ---------------- GOOGLE NAV BAR ----------------
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: kPrimaryColor.withOpacity(0.2),
              hoverColor: kLightPrimaryColor.withOpacity(0.2),
              haptic: true,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              // tabBackgroundGradient: kLightPrimaryGradient,
              tabBackgroundColor: kPrimaryColor,
              color: Colors.grey[700],
              textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: kWhiteColor,
              ),
              tabs: const [
                GButton(icon: Icons.inbox_outlined, text: 'Requests'),
                GButton(icon: Icons.group_outlined, text: 'Employees'),
                GButton(icon: Icons.analytics_outlined, text: 'Stats'),
                GButton(icon: Icons.calendar_today_outlined, text: 'Calendar'),
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
