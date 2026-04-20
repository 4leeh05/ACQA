import 'package:flutter/material.dart';

import '../models/task.dart';
import '../utils/app_theme.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF273449),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Checkbox(
          value: task.isDone,
          activeColor: AppTheme.success,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            decoration: task.isDone ? TextDecoration.lineThrough : null,
            decorationColor: Colors.white70,
          ),
        ),
        subtitle: Text(
          task.isDone ? 'Concluída' : 'Pendente',
          style: TextStyle(
            color: task.isDone ? AppTheme.success : AppTheme.textSecondary,
          ),
        ),
        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline_rounded, color: Colors.white70),
        ),
      ),
    );
  }
}
