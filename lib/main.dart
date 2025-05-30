import 'package:flutter/material.dart';
import 'app.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

// Add this function to show notifications
Future<void> showNotification(String title, String body) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      title: title,
      body: body,
      notificationLayout: NotificationLayout.Default,
      category: NotificationCategory.Reminder,
    ),
    schedule: null,
  );
}

void main() async {
  // Asegúrate de que Flutter esté inicializado
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Awesome Notifications
  AwesomeNotifications().initialize(
    // Define el icono de la aplicación para las notificaciones
    // 'resource://drawable/res_app_icon', // Si tienes un icono específico
    null, // O null si quieres usar el icono por defecto de la app
    [
      NotificationChannel(
        channelKey: 'basic_channel', // Clave única para tu canal
        channelName: 'Basic notifications', // Nombre visible del canal
        channelDescription: 'Notification channel for basic tests', // Descripción del canal
        defaultColor: Color(0xFF9D50DD), // Color por defecto
        ledColor: Colors.white, // Color del LED (si el dispositivo lo soporta)
        importance: NotificationImportance.Max, // Importancia de la notificación
      )
    ],
    debug: true // Ponlo en false en producción
  );

  runApp(const StudyApp());
}