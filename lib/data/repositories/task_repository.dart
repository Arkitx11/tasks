import 'package:tasks/data/mapper/task_mapper.dart';
import 'package:tasks/domain/model/task.dart';

import '../services/database_service.dart';

class TaskRepository {
  final DatabaseService _localDataService;

  const TaskRepository({required DatabaseService localDataService})
    : _localDataService = localDataService;

  Stream<List<Task>> getTasks() {
    return _localDataService.watchTasks().map(
      (event) => event.map((e) => TaskMapper.toDomainTaskModel(e)).toList(),
    );
  }

  Future<void> insertTask(Task task) {
    return _localDataService.insertTask(
      TaskMapper.toDataTaskCompanionModel(task),
    );
  }

  Future<void> updateTask(Task task) {
    return _localDataService.updateTask(TaskMapper.toDataTaskModel(task));
  }

  Future<void> deleteTask(Task task) {
    return _localDataService.deleteTask(task.id);
  }
}
