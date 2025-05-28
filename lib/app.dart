import 'package:flutter/material.dart';
import 'package:study_alert/src/screens/login_screen.dart';

class StudyApp extends StatelessWidget {
  const StudyApp({super.key});

  @override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Study Alert',
    theme: ThemeData.light(useMaterial3: true),
    darkTheme: ThemeData.dark(useMaterial3: true),
    themeMode: ThemeMode.system,
    initialRoute: '/login', // Ruta inicial
    routes: {
     '/login': (context) => const LoginScreen(),
      //'/home': (context) => const HomePage(), */
    },
  );
}
}
