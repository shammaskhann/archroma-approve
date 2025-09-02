import 'package:flutter/material.dart';

class AdminCalendarScreen extends StatelessWidget {
  const AdminCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Calendar',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
