import 'package:erp_admin/attendance_screen.dart';
import 'package:erp_admin/home_screen.dart';
import 'package:erp_admin/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

final pb = PocketBase('https://erp-back2.fly.dev');

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(
        path: '/attendance', builder: (context, state) => AttendanceScreen()),
    GoRoute(path: '/settings', builder: (context, state) => SettingsScreen())
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ERP Admin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

class LoginScreen extends StatelessWidget {
  void login(BuildContext context) async {
    await pb.collection('teachers').authWithOAuth2('google', (url) async {
      await launchUrl(url);
    });

    print(pb.authStore.token);
    if (pb.authStore.isValid) context.go("/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/img_login.png'),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Welcome to ERP",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Text("A simple way to track your attendance"),
            const SizedBox(
              height: 30,
            ),
            FilledButton(
              onPressed: () => login(context),
              child: const Text("Login With Google"),
            ),
          ],
        ),
      ),
    );
  }
}
