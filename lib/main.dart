import 'package:flutter/material.dart';
import 'app.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

// Función para mostrar notificaciones inmediatas con estilo mejorado
Future<void> showNotification(String title, String body) async {
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    // No intentar mostrar notificaciones si no están permitidas
    return;
  }
  
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      title: title,
      body: body,
      notificationLayout: NotificationLayout.Default,
      category: NotificationCategory.Reminder,
      backgroundColor: Color(0xFFE5F4FD), // Color de fondo suave azul claro
      color: Color(0xFF45B7D1),  // Color de acento azul
      largeIcon: "resource://drawable/ic_launcher", // Icono grande (el icono de la app)
      roundedBigPicture: true,   // Imagen redondeada si decides añadir una
      showWhen: true,            // Mostrar la hora de la notificación
    ),
    schedule: null, // Al no tener schedule, la notificación se muestra inmediatamente
    actionButtons: [
      NotificationActionButton(
        key: 'VIEW',
        label: 'Ver detalles',
        color: Color(0xFF45B7D1), // Color del botón que coincide con el acento
      ),
      NotificationActionButton(
        key: 'DISMISS',
        label: 'Descartar',
        color: Colors.grey, // Color neutro para descartar
        isDangerousOption: true,
      ),
    ],
  );
}

// Función para mostrar notificaciones programadas con estilo mejorado
Future<void> showScheduledNotification(String title, String body, {int delaySeconds = 30}) async {
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    // No intentar mostrar notificaciones si no están permitidas
    return;
  }
  
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 11,
      channelKey: 'basic_channel',
      title: title,
      body: body,
      notificationLayout: NotificationLayout.BigText, // Texto grande para mejor visibilidad
      category: NotificationCategory.Reminder,
      backgroundColor: Color(0xFFF0F7FA), // Fondo suave azul muy claro
      color: Color(0xFF286BF4),  // Color de acento azul más intenso
      largeIcon: "resource://drawable/ic_launcher",
      wakeUpScreen: true,  // Despertar pantalla para notificaciones importantes
      showWhen: true,
    ),
    schedule: NotificationCalendar(
      second: DateTime.now().second + delaySeconds % 60,
      minute: DateTime.now().minute + (DateTime.now().second + delaySeconds) ~/ 60,
      hour: DateTime.now().hour,
      day: DateTime.now().day,
      month: DateTime.now().month,
      year: DateTime.now().year,
      preciseAlarm: true, // Para alarmas más precisas
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Completar',
        color: Color(0xFF4ECDC4), // Verde suave para acción positiva
      ),
      NotificationActionButton(
        key: 'SNOOZE',
        label: 'Recordarme',
        color: Color(0xFF9D50DD), // Color púrpura suave
      ),
    ],
  );
}

// Solicita permisos de notificación al usuario
Future<void> requestNotificationPermissions() async {
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }
}

void main() async {
  // Asegúrate de que Flutter esté inicializado
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Awesome Notifications con canales personalizados
  AwesomeNotifications().initialize(
    null, // Usar icono por defecto
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Notificaciones de Study Alert',
        channelDescription: 'Información sobre tus próximas tareas y actividades',
        defaultColor: Color(0xFF286BF4),
        ledColor: Colors.white,
        ledOnMs: 1000,
        ledOffMs: 500,
        importance: NotificationImportance.High,
        playSound: true,
        soundSource: 'resource://raw/notification_sound',
        enableVibration: true,
        vibrationPattern: highVibrationPattern,
      )
    ],
    debug: true
  );

  // Solicitar permisos de notificación antes de intentar mostrar una notificación
  await requestNotificationPermissions();
  
  // Mostrar notificación de bienvenida con estilo mejorado
  await showNotification(
    "¡Bienvenido a Study Alert!",
    "Organiza tus tareas y mantente al día con tus actividades académicas"
  );

  runApp(const StudyApp());
}