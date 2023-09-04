import 'package:erp_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  int _selectedIndex = 1;

  void pickDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: DateTime(2024));

    if (date == null) return;

    if (!context.mounted) return;

    final a = await pb
        .collection("classes")
        .getFirstListItem("teacher='${pb.authStore.model!.id}'");
    print(a);
  }

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
            if (value == 0) {
              context.go("/home");
            }
          },
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Attendance",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                  const Text("Mark attendance for your period"),
                  FilledButton(
                      onPressed: () => pickDate(context),
                      child: const Text("Pick Date"))
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
