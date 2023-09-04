import 'package:erp_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketbase/pocketbase.dart';

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

    if (date == null) throw Exception("dsfds");

    if (!context.mounted) throw Exception("dfgjdfkhgjkdfgbnkhjdg");
    // d = date;
    // classes = getClasses();
  }

  Future<RecordModel>? getClasses() async {
    final a = await pb.collection("classes").getFirstListItem(
        "teacher='${pb.authStore.model!.id}'",
        expand: "users");
    return a;
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
            Text("Attendance",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
            const Text("Mark attendance for your period"),
            Expanded(
              child: FutureBuilder<RecordModel>(
                  future: getClasses(),
                  builder: (context, snapshot) {
                    print(snapshot.connectionState);
                    if (snapshot.hasData) {
                      final users = snapshot.data!.data;
                      print(users['users'].length);
                      print(users['users']);
                      return ListView.builder(itemBuilder: (context, i) {
                        return Container(
                          color: Colors.orange,
                          child: ListTile(
                            trailing: Icon(Icons.deblur),
                          ),
                        );
                      });
                    } else if (snapshot.hasError) {
                      return const Text("Error");
                    }
                    return const CircularProgressIndicator();
                  }),
            ),
          ],
        )
      ]),
    );
  }
}
