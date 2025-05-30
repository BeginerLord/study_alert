import 'package:flutter/material.dart';
import 'package:study_alert/src/components/MainTabsPage.dart';
import 'package:study_alert/src/screens/dashboard_screen.dart';
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
        '/dashboard': (context) {
          final args =
              ModalRoute.of(context)?.settings.arguments
                  as Map<String, dynamic>?;
          final userCedula =
              args != null && args['userCedula'] != null
                  ? args['userCedula']
                  : '';
          return DashboardScreen(userCedula: userCedula);
        }, // Cambia esto a tu pantalla de dashboard
        //'/home': (context) => const HomePage(), */
        '/mainTabs': (context) => const MainTabsPage(),
      },
    );
  }
}
