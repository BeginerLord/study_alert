import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'app.dart'; // Importar la clase StudyApp

// Controla si la app está en segundo plano
bool isAppInBackground = false;

// Variable para evitar notificaciones repetidas de la misma tarea
int? _lastNotifiedTaskId;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Awesome Notifications
  await AwesomeNotifications().initialize(
    null,
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
        enableVibration: true,
      ),
      NotificationChannel(
        channelKey: 'reminder_channel',
        channelName: 'Recordatorios Urgentes',
        channelDescription: 'Recordatorios cuando minimizas la app',
        defaultColor: Color(0xFFEA580C),
        ledColor: Colors.red,
        ledOnMs: 1000,
        ledOffMs: 500,
        importance: NotificationImportance.Max,
        playSound: true,
        enableVibration: true,
        criticalAlerts: true,
      ),
    ],
    debug: true, // mantener debug en true para ver errores
  );

  await requestNotificationPermissions();

  // Detectar cuando la app cambia de estado (foreground/background)
  SystemChannels.lifecycle.setMessageHandler((msg) async {
    if (msg == AppLifecycleState.paused.toString()) {
      isAppInBackground = true;
      await showReminderWhenMinimized();
    } else if (msg == AppLifecycleState.resumed.toString()) {
      isAppInBackground = false;
      _lastNotifiedTaskId = null; // reset al volver al foreground
    }
    return null;
  });

  // Ejecuta StudyApp en lugar de MyApp
  runApp(const StudyApp());
}

// Solicitar permisos para notificaciones
Future<void> requestNotificationPermissions() async {
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }
}

// Función para mostrar notificaciones programadas
Future<void> showScheduledNotification(String title, String body, {int delaySeconds = 30}) async {
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    return;
  }
  
  try {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 11,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.BigText,
        category: NotificationCategory.Reminder,
        backgroundColor: Color(0xFFF0F7FA),
        color: Color(0xFF286BF4),
        largeIcon: "resource://drawable/ic_launcher",
        wakeUpScreen: true,
        showWhen: true,
        payload: {'type': 'scheduled_task'},
      ),
      schedule: NotificationCalendar(
        second: DateTime.now().second + delaySeconds % 60,
        minute: DateTime.now().minute + (DateTime.now().second + delaySeconds) ~/ 60,
        hour: DateTime.now().hour,
        day: DateTime.now().day,
        month: DateTime.now().month,
        year: DateTime.now().year,
        preciseAlarm: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'MARK_DONE',
          label: 'Completar',
          color: Color(0xFF4ECDC4),
        ),
        NotificationActionButton(
          key: 'SNOOZE',
          label: 'Recordarme',
          color: Color(0xFF9D50DD),
        ),
      ],
    );
  } catch (e) {
    debugPrint("Error al programar notificación: $e");
  }
}

// Simulación de un servicio de datos (a reemplazar con tu lógica real)
class DataService {
  Future<List<Task>> getUpcomingTasks() async {
    // Simular un pequeño retardo como en una petición real
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Fecha actual para compararla con las fechas de las tareas
    final now = DateTime.now();
    
    // Fecha para prueba (siempre dentro del rango de 24 horas para garantizar que se muestre)
    final testDate = DateTime(now.year, now.month, now.day + 1, 10, 0); // Mañana a las 10:00
    final testDateFormatted = "${testDate.year}-${testDate.month.toString().padLeft(2, '0')}-${testDate.day.toString().padLeft(2, '0')}";
    
    return [
      Task(
        id: 3,
        idUser: "1062957207",
        fecha: testDateFormatted, // Asegurando que sea una fecha futura cercana
        dia: _getDayName(testDate.weekday),
        tipoEvento: "Examen parcial",
        prioridad: 1,
        titulo: "Examen Unidad 3",
        asignatura: "BASES DE DATOS - CERETÉ - F1 - 2025 - 1",
        hora: "${testDate.hour.toString().padLeft(2, '0')}:${testDate.minute.toString().padLeft(2, '0')}",
        done: false,
        snoozedUntil: null,
      ),
      Task(
        id: 2,
        idUser: "1062957207",
        fecha: "2025-06-01", // Esta fecha puede quedar fuera del rango
        dia: "domingo",
        tipoEvento: "Entrega de tarea",
        prioridad: 2,
        titulo: "Informe final del proyecto",
        asignatura: "ANÁLISIS Y DISEÑO DE SISTEMAS - CERETÉ - F2 - 2025 - 1",
        hora: "22:00",
        done: false,
        snoozedUntil: null,
      ),
    ];
  }
  
  // Función helper para obtener el nombre del día de la semana
  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return "lunes";
      case 2: return "martes";
      case 3: return "miércoles";
      case 4: return "jueves";
      case 5: return "viernes";
      case 6: return "sábado";
      case 7: return "domingo";
      default: return "desconocido";
    }
  }
}

// Modelo de tarea
class Task {
  final int id;
  final String idUser;
  final String fecha;
  final String dia;
  final String tipoEvento;
  final int prioridad;
  final String titulo;
  final String asignatura;
  final String hora;
  final bool done;
  final String? snoozedUntil;

  Task({
    required this.id,
    required this.idUser,
    required this.fecha,
    required this.dia,
    required this.tipoEvento,
    required this.prioridad,
    required this.titulo,
    required this.asignatura,
    required this.hora,
    required this.done,
    this.snoozedUntil,
  });
}

// Mostrar notificación cuando la app se minimice
Future<void> showReminderWhenMinimized() async {
  // Esperamos 2 segundos después de minimizar
  await Future.delayed(const Duration(seconds: 2));

  // Verificamos si la app sigue en segundo plano después del delay
  if (!isAppInBackground) {
    return;
  }
  
  try {
    final dataService = DataService();
    final tasks = await dataService.getUpcomingTasks();

    final now = DateTime.now();

    final upcomingTasks = tasks.where((task) {
      try {
        final taskDate = DateTime.parse('${task.fecha}T${task.hora}:00');
        final diff = taskDate.difference(now);
        final isUpcoming = !task.done && diff.inMinutes > 0 && diff.inHours <= 24;
        return isUpcoming;
      } catch (e) {
        return false;
      }
    }).toList();

    if (upcomingTasks.isEmpty) {
      return;
    }

    upcomingTasks.sort((a, b) => a.prioridad.compareTo(b.prioridad));
    final task = upcomingTasks.first;
    
    // Evitar notificaciones repetidas
    if (_lastNotifiedTaskId == task.id) {
      return;
    }
    _lastNotifiedTaskId = task.id;

    String priorityText = task.prioridad <= 3
        ? "¡Alta prioridad!"
        : task.prioridad <= 5
            ? "Prioridad media"
            : "Prioridad baja";

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 12,
        channelKey: 'reminder_channel',
        title: '⏰ ¡No olvides tu tarea pendiente!',
        body:
            '${task.titulo} - ${priorityText}\n${task.dia}, ${task.fecha.substring(5)} a las ${task.hora}\n${task.asignatura.split(' - ')[0]}',
        notificationLayout: NotificationLayout.BigText,
        category: NotificationCategory.Reminder,
        backgroundColor: const Color(0xFFF0F7FA),
        color: const Color(0xFF286BF4),
        largeIcon: "resource://drawable/ic_launcher",
        wakeUpScreen: true,
        showWhen: true,
        payload: {'taskId': task.id.toString()}, // Para identificar la tarea al interactuar
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'OPEN_APP',
          label: 'Ir a la app',
          color: const Color(0xFF286BF4),
        ),
      ],
    );
  } catch (e) {
    debugPrint("Error al mostrar notificación de recordatorio: $e");
  }
}