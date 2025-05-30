import 'package:flutter/material.dart';
import 'package:study_alert/src/components/PageContainer.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: 'Tasks',
      scrollable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pagina de las tareas'),
          SizedBox(height: 20),
          // Tu contenido personalizado
        ],
      ),
    );
  }
}
