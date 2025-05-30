import 'package:flutter/material.dart';
import 'package:study_alert/src/components/PageContainer.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: 'Profile',
      scrollable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pagina '),
          SizedBox(height: 20),
          // Tu contenido personalizado
        ],
      ),
    );
  }
}
