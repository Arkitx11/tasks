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
      dateTime: task.dueDate,
      description: task.description,
    );
  }

  static data.TasksCompanion toDataTaskCompanionModel(domain.Task task) {
    return data.TasksCompanion(
      title: Value(task.title),
      description: (task.description != null) ? Value(task.description!) : Value.absent(),
      dueDate: (task.dateTime != null) ? Value(task.dateTime!) : Value.absent(),
      isComplete: Value(task.isComplete),
      isFavourite: Value(task.isFavoruite),
    );
  }

  /// TODO: This will cause a fucking rukus due to the due data, fucking shit
  static data.Task toDataTaskModel(domain.Task task) {
    return data.Task(
      id: task.id!,
      title: task.title,
      dueDate: task.dateTime!,
      description: task.description,
      isFavourite: task.isFavoruite,
      isComplete: task.isComplete,
    );
  }
}
