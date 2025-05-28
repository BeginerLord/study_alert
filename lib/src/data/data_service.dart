// Servicio para manejar los datos simulados
class DataService {
  // Datos simulados de usuarios
  final List<Map<String, dynamic>> _usersData = [
    {
      "id_user": "1062957207",
      "name": "Ana Paula",
      "img": "assets/user.png" // sin barra inicial para AssetImage
    }
  ];

  // Datos simulados de tareas con campo prioridad agregado
  final List<Map<String, dynamic>> _tasksData = [
    {
      "id": 1,
      "id_user": 1062957207,
      "fecha": "2025-05-30",
      "dia": "viernes",
      "tipoEvento": "Evento de actividad",
      "prioridad": 7,
      "titulo": "Protocolo colaborativo de la unidad 4",
      "asignatura": "INGENIERÍA DE SOFTWARE - CERETÉ - ORGANIZACION DE COMPUTADORES - F1 - 2025 - 1 - Vencimiento de Tarea",
      "hora": "23:59",
      "done": false,
      "snoozedUntil": null
    },
    {
      "id": 2,
      "id_user": 1062957207,
      "fecha": "2025-06-01",
      "dia": "domingo",
      "tipoEvento": "Entrega de tarea",
      "prioridad": 3,
      "titulo": "Informe final del proyecto",
      "asignatura": "ANÁLISIS Y DISEÑO DE SISTEMAS - CERETÉ - F2 - 2025 - 1",
      "hora": "22:00",
      "done": false,
      "snoozedUntil": null
    },
    {
      "id": 3,
      "id_user": 1062957207,
      "fecha": "2025-06-03",
      "dia": "martes",
      "tipoEvento": "Examen parcial",
      "prioridad": 1,
      "titulo": "Examen Unidad 3",
      "asignatura": "BASES DE DATOS - CERETÉ - F1 - 2025 - 1",
      "hora": "10:00",
      "done": false,
      "snoozedUntil": null
    },
    {
      "id": 4,
      "id_user": 1062957207,
      "fecha": "2025-06-05",
      "dia": "jueves",
      "tipoEvento": "Reunión",
      "prioridad": 5,
      "titulo": "Revisión de avances de proyecto final",
      "asignatura": "GESTIÓN DE PROYECTOS - CERETÉ - F3 - 2025 - 1",
      "hora": "15:30",
      "done": false,
      "snoozedUntil": null
    },
    {
      "id": 5,
      "id_user": 1062957207,
      "fecha": "2025-06-06",
      "dia": "viernes",
      "tipoEvento": "Entrega de tarea",
      "prioridad": 3,
      "titulo": "Entrega de reporte de práctica",
      "asignatura": "SISTEMAS OPERATIVOS - CERETÉ - F1 - 2025 - 1",
      "hora": "20:00",
      "done": false,
      "snoozedUntil": null
    },
    {
      "id": 6,
      "id_user": 1062957207,
      "fecha": "2025-06-07",
      "dia": "sábado",
      "tipoEvento": "Exposición",
      "prioridad": 4,
      "titulo": "Presentación del proyecto de investigación",
      "asignatura": "INVESTIGACIÓN - CERETÉ - F2 - 2025 - 1",
      "hora": "14:00",
      "done": false,
      "snoozedUntil": null
    },
    {
      "id": 7,
      "id_user": 1062957207,
      "fecha": "2025-06-08",
      "dia": "domingo",
      "tipoEvento": "Evaluación",
      "prioridad": 2,
      "titulo": "Prueba corta Unidad 2",
      "asignatura": "PROGRAMACIÓN - CERETÉ - F3 - 2025 - 1",
      "hora": "09:00",
      "done": false,
      "snoozedUntil": null
    },
    {
      "id": 8,
      "id_user": 1062957207,
      "fecha": "2025-06-09",
      "dia": "lunes",
      "tipoEvento": "Seminario",
      "prioridad": 6,
      "titulo": "Seminario de innovación tecnológica",
      "asignatura": "TECNOLOGÍA - CERETÉ - F1 - 2025 - 1",
      "hora": "11:00",
      "done": false,
      "snoozedUntil": null
    }
  ];

  // Datos simulados para planner
  final List<Map<String, dynamic>> _plannerData = [
    {
      "fecha": "2025-05-27",
      "hora": "23:59",
      "titulo": "Actividad Unidad 3",
      "asignatura": "ARQUITECTURA DE SOFTWARE - CERETÉ - F1 - 2025 - 1",
      "tipoEvento": "Entrega de tarea"
    },
    {
      "fecha": "2025-05-28",
      "hora": "20:00",
      "titulo": "Revisión del proyecto final",
      "asignatura": "GESTIÓN DE PROYECTOS - CERETÉ - F3 - 2025 - 1",
      "tipoEvento": "Reunión"
    }
  ];

  // Obtener usuario actual
  User? getCurrentUser(String userCedula) {
    try {
      final userData = _usersData.firstWhere(
        (user) => user["id_user"].toString() == userCedula,
      );
      return User.fromJson(userData);
    } catch (e) {
      return null;
    }
  }

  // Obtener tareas del usuario
  List<Task> getUserTasks(String userCedula) {
    final userTasks = _tasksData.where(
      (task) => task["id_user"].toString() == userCedula,
    ).toList();

    return userTasks.map((data) => Task.fromJson(data)).toList();
  }

  // Obtener eventos del planner
  List<PlannerEvent> getPlannerEvents() {
    return _plannerData.map((e) => PlannerEvent.fromJson(e)).toList();
  }
}

// Modelo de Usuario
class User {
  final String idUser;
  final String name;
  final String img;

  User({
    required this.idUser,
    required this.name,
    required this.img,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['id_user'].toString(),
      name: json['name'],
      img: json['img'],
    );
  }
}

// Modelo de Tarea
class Task {
  final int id;
  final String idUser;
  final String fecha;
  final String dia;
  final String tipoEvento;
  final int prioridad; // nuevo campo prioridad
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

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      idUser: json['id_user'].toString(),
      fecha: json['fecha'],
      dia: json['dia'],
      tipoEvento: json['tipoEvento'],
      prioridad: json['prioridad'] ?? 999,
      titulo: json['titulo'],
      asignatura: json['asignatura'],
      hora: json['hora'],
      done: json['done'],
      snoozedUntil: json['snoozedUntil'],
    );
  }
}

// Modelo para eventos del planner
class PlannerEvent {
  final String fecha;
  final String hora;
  final String titulo;
  final String asignatura;
  final String tipoEvento;

  PlannerEvent({
    required this.fecha,
    required this.hora,
    required this.titulo,
    required this.asignatura,
    required this.tipoEvento,
  });

  factory PlannerEvent.fromJson(Map<String, dynamic> json) {
    return PlannerEvent(
      fecha: json['fecha'],
      hora: json['hora'],
      titulo: json['titulo'],
      asignatura: json['asignatura'],
      tipoEvento: json['tipoEvento'],
    );
  }
}
