import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';
import '../services/auth_service.dart';
import '../services/task_service.dart';
import '../utils/app_theme.dart';
import '../widgets/info_card.dart';
import '../widgets/task_tile.dart';

class TasksScreen extends StatefulWidget {
  final DateTime selectedDate;

  const TasksScreen({super.key, required this.selectedDate});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late String dateKey;

  @override
  void initState() {
    super.initState();
    dateKey = DateFormat('yyyy-MM-dd').format(widget.selectedDate);
  }

  void _showAddTaskDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Adicionar tarefa'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Nome da tarefa',
              hintText: 'Digite a tarefa do dia',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final text = controller.text.trim();
                if (text.isEmpty) return;

                final task = Task(
                  id: DateTime.now().microsecondsSinceEpoch.toString(),
                  title: text,
                  isDone: false,
                );

                setState(() {
                  TaskService.addTask(dateKey, task);
                });

                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(widget.selectedDate);
    final tasks = TaskService.getTasks(dateKey);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppTheme.mainGradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 14,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _showAddTaskDialog,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Bem-vindo, ${AuthService.currentUserName}!',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Dia $formattedDate',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: InfoCard(
                      child: tasks.isEmpty
                          ? const Center(
                              child: Text(
                                'Nenhuma tarefa cadastrada para este dia.',
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.builder(
                              itemCount: tasks.length,
                              itemBuilder: (context, index) {
                                final task = tasks[index];
                                return TaskTile(
                                  task: task,
                                  onToggle: () {
                                    setState(() {
                                      TaskService.toggleTask(dateKey, task.id);
                                    });
                                  },
                                  onDelete: () {
                                    setState(() {
                                      TaskService.removeTask(dateKey, task.id);
                                    });
                                  },
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
