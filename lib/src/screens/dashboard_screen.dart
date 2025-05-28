import 'package:flutter/material.dart';
import 'package:study_alert/src/data/data_service.dart';

class DashboardScreen extends StatefulWidget {
  final String userCedula;

  const DashboardScreen({super.key, required this.userCedula});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Task> _tasks = [];
  User? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Datos estáticos del usuario con ruta correcta sin barra inicial
    _currentUser = User(
      idUser: "1062957207",
      name: "Ana Paula",
      img: "assets/user.png", // sin "/" al inicio para AssetImage
    );

    // Datos estáticos de tareas con prioridades
    _tasks = [
      Task(
        id: 1,
        idUser: "1062957207",
        fecha: "2025-05-30",
        dia: "viernes",
        tipoEvento: "Evento de actividad",
        prioridad: 5,
        titulo: "Protocolo colaborativo de la unidad 4",
        asignatura: "INGENIERÍA DE SOFTWARE - CERETÉ - ORGANIZACION DE COMPUTADORES - F1 - 2025 - 1",
        hora: "23:59",
        done: false,
        snoozedUntil: null,
      ),
      Task(
        id: 2,
        idUser: "1062957207",
        fecha: "2025-06-01",
        dia: "domingo",
        tipoEvento: "Entrega de tarea",
        prioridad: 2,
        titulo: "Informe final del proyecto",
        asignatura: "ANÁLISIS Y DISEÑO DE SISTEMAS - CERETÉ - F2 - 2025 - 1",
        hora: "22:00",
        done: false,
        snoozedUntil: null,
      ),
      Task(
        id: 3,
        idUser: "1062957207",
        fecha: "2025-06-03",
        dia: "martes",
        tipoEvento: "Examen parcial",
        prioridad: 1,
        titulo: "Examen Unidad 3",
        asignatura: "BASES DE DATOS - CERETÉ - F1 - 2025 - 1",
        hora: "10:00",
        done: false,
        snoozedUntil: null,
      ),
      Task(
        id: 4,
        idUser: "1062957207",
        fecha: "2025-06-05",
        dia: "jueves",
        tipoEvento: "Reunión",
        prioridad: 6,
        titulo: "Revisión de avances de proyecto final",
        asignatura: "GESTIÓN DE PROYECTOS - CERETÉ - F3 - 2025 - 1",
        hora: "15:30",
        done: false,
        snoozedUntil: null,
      ),
      Task(
        id: 5,
        idUser: "1062957207",
        fecha: "2025-06-06",
        dia: "viernes",
        tipoEvento: "Entrega de tarea",
        prioridad: 3,
        titulo: "Entrega de reporte de práctica",
        asignatura: "SISTEMAS OPERATIVOS - CERETÉ - F1 - 2025 - 1",
        hora: "20:00",
        done: false,
        snoozedUntil: null,
      ),
      Task(
        id: 6,
        idUser: "1062957207",
        fecha: "2025-06-07",
        dia: "sábado",
        tipoEvento: "Exposición",
        prioridad: 4,
        titulo: "Presentación del proyecto de investigación",
        asignatura: "INVESTIGACIÓN - CERETÉ - F2 - 2025 - 1",
        hora: "14:00",
        done: false,
        snoozedUntil: null,
      ),
      Task(
        id: 7,
        idUser: "1062957207",
        fecha: "2025-06-08",
        dia: "domingo",
        tipoEvento: "Evaluación",
        prioridad: 7,
        titulo: "Prueba corta Unidad 2",
        asignatura: "PROGRAMACIÓN - CERETÉ - F3 - 2025 - 1",
        hora: "09:00",
        done: false,
        snoozedUntil: null,
      ),
      Task(
        id: 8,
        idUser: "1062957207",
        fecha: "2025-06-09",
        dia: "lunes",
        tipoEvento: "Seminario",
        prioridad: 4,
        titulo: "Seminario de innovación tecnológica",
        asignatura: "TECNOLOGÍA - CERETÉ - F1 - 2025 - 1",
        hora: "11:00",
        done: false,
        snoozedUntil: null,
      ),
    ];

    setState(() {
      _isLoading = false;
    });
  }

  List<Task> _getTasksByPriority() {
    final tasksCopy = _tasks.where((task) => !task.done).toList();

    tasksCopy.sort((a, b) {
      if (a.prioridad != b.prioridad) {
        return a.prioridad.compareTo(b.prioridad);
      }
      return DateTime.parse(a.fecha).compareTo(DateTime.parse(b.fecha));
    });

    return tasksCopy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: _isLoading
          ? _buildLoadingScreen()
          : CustomScrollView(
              slivers: [
                _buildSliverAppBar(),
                SliverToBoxAdapter(child: _buildDashboardContent()),
              ],
            ),
    );
  }

  Widget _buildLoadingScreen() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4568DC), Color(0xFF3F5EFB)], // Nuevos colores azules
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 3,
            ),
            SizedBox(height: 20),
            Text(
              'Cargando tu dashboard...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4568DC), Color(0xFF3F5EFB)], // Nuevos colores azules
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 37,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(_currentUser?.img ?? 'assets/user.png'),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '¡Hola, ${_currentUser?.name ?? 'Usuario'}!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Gestiona tus tareas y planifica tu semana',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardContent() {
    return Column(
      children: [
        _buildStatsCards(),
        _buildTasksByPrioritySection(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildStatsCards() {
    final totalTasks = _tasks.length;
    final completedTasks = _tasks.where((task) => task.done).length;
    final pendingTasks = totalTasks - completedTasks;

    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Pendientes',
              pendingTasks.toString(),
              Icons.pending_actions,
              const Color(0xFFFF6B6B),
              const Color(0xFFFFE5E5),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildStatCard(
              'Completadas',
              completedTasks.toString(),
              Icons.check_circle,
              const Color(0xFF4ECDC4),
              const Color(0xFFE5F9F7),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildStatCard(
              'Total',
              totalTasks.toString(),
              Icons.assignment,
              const Color(0xFF45B7D1),
              const Color(0xFFE5F4FD),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksByPrioritySection() {
    final priorityTasks = _getTasksByPriority();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE5E5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.priority_high,
                  color: Color(0xFFFF6B6B),
                  size: 16,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Tareas por Prioridad',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3748),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (priorityTasks.isEmpty)
            _buildEmptyState()
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: priorityTasks.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  task: priorityTasks[index],
                  priorityIndex: priorityTasks[index].prioridad,
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFF7FAFC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.task_alt,
              size: 40,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '¡Excelente trabajo!',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'No tienes tareas pendientes por el momento',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Task task;
  final int priorityIndex;

  const TaskCard({
    super.key,
    required this.task,
    required this.priorityIndex,
  });

  Color _getPriorityColor() {
    switch (priorityIndex) {
      case 1:
        return const Color(0xFFDC2626); // Rojo intenso - Crítica
      case 2:
        return const Color(0xFFEA580C); // Naranja - Alta
      case 3:
        return const Color(0xFFD97706); // Amarillo oscuro - Media-Alta
      case 4:
        return const Color(0xFFCA8A04); // Amarillo - Media
      case 5:
        return const Color(0xFF65A30D); // Verde amarillento - Media-Baja
      case 6:
        return const Color(0xFF059669); // Verde - Baja
      case 7:
        return const Color(0xFF0891B2); // Azul - Muy Baja
      default:
        return const Color(0xFF6B7280); // Gris - Sin prioridad
    }
  }

  Color _getPriorityBgColor() {
    switch (priorityIndex) {
      case 1:
        return const Color(0xFFFEE2E2); // Rojo claro
      case 2:
        return const Color(0xFFFED7AA); // Naranja claro
      case 3:
        return const Color(0xFFFEF3C7); // Amarillo claro
      default:
        return const Color(0xFFF3F4F6); // Color por defecto
    }
  }

  IconData _getEventIcon() {
    switch (task.tipoEvento.toLowerCase()) {
      case 'examen parcial':
      case 'evaluación':
        return Icons.quiz;
      case 'entrega de tarea':
        return Icons.assignment_turned_in;
      case 'reunión':
        return Icons.meeting_room;
      case 'seminario':
        return Icons.school;
      case 'evento de actividad':
        return Icons.event_note;
      case 'exposición':
        return Icons.present_to_all;
      default:
        return Icons.event;
    }
  }

  String _getPriorityText() {
    switch (priorityIndex) {
      case 1:
        return 'Crítica';
      case 2:
        return 'Alta';
      case 3:
        return 'Media-Alta';
      case 4:
        return 'Media';
      case 5:
        return 'Media-Baja';
      case 6:
        return 'Baja';
      case 7:
        return 'Muy Baja';
      default:
        return 'Sin prioridad';
    }
  }

  @override
  Widget build(BuildContext context) {
    final priorityColor = _getPriorityColor();
    final priorityBgColor = _getPriorityBgColor();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Contenido principal de la tarjeta
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Etiqueta de prioridad
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: priorityBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getPriorityText(),
                    style: TextStyle(
                      color: priorityColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Icono del tipo de evento
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    _getEventIcon(),
                    color: priorityColor,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 12),
                // Detalles de la tarea
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.titulo,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        task.asignatura.split(' - ')[0],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 12,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${task.dia}, ${task.fecha.substring(5)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            task.hora,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Indicador vertical de prioridad
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: Container(
              width: 5,
              decoration: BoxDecoration(
                color: priorityColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}