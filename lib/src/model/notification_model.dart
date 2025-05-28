class NotificationModel {
  final String titulo;
  final String prioridad;
  final String asignatura;
  final String tiempoRestante;
  final String mensaje;

  NotificationModel({
    required this.titulo,
    required this.prioridad,
    required this.asignatura,
    required this.tiempoRestante,
    this.mensaje = "",
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      titulo: json['titulo'],
      prioridad: json['prioridad'],
      asignatura: json['asignatura'],
      tiempoRestante: json['tiempoRestante'],
      mensaje: json['mensaje'] ?? '',
    );
  }
}
