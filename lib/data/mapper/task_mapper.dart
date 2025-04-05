import 'package:drift/drift.dart';
import 'package:tasks/data/database/database.dart'
    as data; // representing model in data layer

import '../../domain/model/task.dart'
    as domain; // representing model in domain layer

// Helpers functions to convert data from domain to data
class TaskMapper {
  static domain.Task toDomainTaskModel(data.Task task) {
    return domain.Task(
      id: task.id,
      title: task.title,
      isFavoruite: task.isFavourite,
      isComplete: task.isComplete,
      dueDate: task.dueDate,
      description: task.description,
    );
  }

  static data.TasksCompanion toDataTaskCompanionModel(domain.Task task) {
    return data.TasksCompanion(
      id: Value(task.id),
      title: Value(task.title),
      description: Value(task.description),
      dueDate: (task.dueDate != null) ? Value(task.dueDate!) : Value.absent(),
      isComplete: Value(task.isComplete),
      isFavourite: Value(task.isFavoruite),
    );
  }

  /// TODO: This will cause a fucking rukus due to the due data, fucking shit
  static data.Task toDataTaskModel(domain.Task task) {
    return data.Task(
      id: task.id,
      title: task.title,
      dueDate: task.dueDate!,
      description: task.description,
      isFavourite: task.isFavoruite,
      isComplete: task.isComplete,
    );
  }
}
