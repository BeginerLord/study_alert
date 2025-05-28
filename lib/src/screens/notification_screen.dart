import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:study_alert/src/model/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Inicializar el plugin de notificaciones
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // JSON con mensaje motivacional incluido
  final Map<String, dynamic> notificationData = {
    "descripcion":
        "Notificaciones con información esencial sobre tareas y eventos.",
    "notificaciones": [
      {
        "titulo": "Protocolo colaborativo de la unidad 4",
        "prioridad": "alta",
        "asignatura": "Algoritmos y Programación Básica",
        "tiempoRestante": "2 días",
        "mensaje":
            "¡Tú puedes hacerlo! Esta tarea te ayudará a comprender mejor los conceptos fundamentales. ¡Cada paso te acerca más a ser un excelente programador!",
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _initNotifications();
    _simulateNotification();
  }

  Future<void> _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _simulateNotification() {
    // Simular la llegada de una notificación después de 1 segundo
    Timer(const Duration(seconds: 1), () {
      final notificationJson = notificationData['notificaciones'][0];
      final notification = NotificationModel.fromJson(notificationJson);

      // Mostrar la notificación en la barra de notificaciones
      _showNotificationInBar(notification);
    });
  }

  Future<void> _showNotificationInBar(NotificationModel notification) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'alerta_estudio_id',
          'Alertas de Estudio',
          channelDescription: 'Canal para notificaciones de estudio',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    // Contenido de la notificación
    final body =
        "Asignatura: ${notification.asignatura}\n"
        "Tiempo restante: ${notification.tiempoRestante}\n\n"
        "${notification.mensaje}";

    await flutterLocalNotificationsPlugin.show(
      0,
      notification.titulo,
      body,
      notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text(
          "Notificación enviada a la barra del sistema",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
