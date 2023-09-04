import 'package:erp_admin/main.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        NavigationRail(
          labelType: NavigationRailLabelType.all,
          destinations: const <NavigationRailDestination>[
            NavigationRailDestination(
              icon: Icon(Icons.home_filled),
              label: Text('Home'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.calendar_month),
              label: Text('Attendance'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
          ],
          selectedIndex: _selectedIndex,
          onDestinationSelected: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Home",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                  const Text("Attendance for Open Source Technologies")
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
