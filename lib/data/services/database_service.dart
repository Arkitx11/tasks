import 'package:tasks/data/database/database.dart';

// Apparently database.dart has TaskCompanion datatype which can be used to insert Element and update Taskk
class DatabaseService {
  final AppDatabase _database;

  DatabaseService({required AppDatabase database}) : _database = database;

  Stream<List<Task>> watchTasks() =>
      (_database.select(_database.tasks)).watch();

  Future<int> insertTask(TasksCompanion task) =>
      _database.into(_database.tasks).insert(task);

  Future<int> deleteTask(int taskId) =>
      (_database.delete(_database.tasks)
        ..where((e) => e.id.equals(taskId))).go();

  Future<bool> updateTask(Task task) =>
      _database.update(_database.tasks).replace(task);
}
