import 'package:flutter/material.dart';

class PriorityBadge extends StatelessWidget {
  final String prioridad;

  const PriorityBadge({
    super.key,
    required this.prioridad,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor = Colors.white;

    switch (prioridad.toLowerCase()) {
      case 'alta':
        backgroundColor = Colors.red;
        break;
      case 'media':
        backgroundColor = Colors.orange;
        break;
      case 'baja':
        backgroundColor = Colors.green;
        break;
      default:
        backgroundColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        prioridad.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TimeBadge extends StatelessWidget {
  final String tiempoRestante;

  const TimeBadge({
    super.key,
    required this.tiempoRestante,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.access_time,
            size: 12,
            color: Colors.blue.shade700,
          ),
          const SizedBox(width: 4),
          Text(
            tiempoRestante,
            style: TextStyle(
              color: Colors.blue.shade700,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
