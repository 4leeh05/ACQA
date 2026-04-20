import '../models/task.dart';

class TaskService {
  static final Map<String, List<Task>> _tasksByDate = {};

  static List<Task> getTasks(String dateKey) {
    final tasks = List<Task>.from(_tasksByDate[dateKey] ?? []);
    tasks.sort((a, b) {
      if (a.isDone != b.isDone) {
        return a.isDone ? 1 : -1;
      }
      return a.title.toLowerCase().compareTo(b.title.toLowerCase());
    });
    return tasks;
  }

  static void addTask(String dateKey, Task task) {
    _tasksByDate.putIfAbsent(dateKey, () => []);
    _tasksByDate[dateKey]!.add(task);
  }

  static void toggleTask(String dateKey, String taskId) {
    final list = _tasksByDate[dateKey];
    if (list == null) return;

    for (final task in list) {
      if (task.id == taskId) {
        task.isDone = !task.isDone;
        break;
      }
    }
  }

  static void removeTask(String dateKey, String taskId) {
    final list = _tasksByDate[dateKey];
    if (list == null) return;
    list.removeWhere((task) => task.id == taskId);
  }
}
