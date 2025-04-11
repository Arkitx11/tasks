import 'package:flutter/material.dart';
import 'package:tasks/data/repositories/task_repository.dart';
import 'package:tasks/ui/mapper/ui_layer_mapper.dart';
import 'package:tasks/ui/task_draft.dart';

import '../domain/model/task.dart';

// TODO(refactor): TaskViewModel functions should implement either Result pattern or enums and avoid rethrowing error

class TaskViewModel {
  final TaskRepository _taskRepository;

  TaskViewModel({required TaskRepository taskRepository})
    : _taskRepository = taskRepository;

  Stream<List<Task>> get taskList => _taskRepository.getTasks();

  Future<void> onTaskCompletion(Task task) async {
    try {
      await _taskRepository.deleteTask(task);
      print('Task Deleted Successfully: ${task.id}');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> onPressingSave(TaskDraft taskDraft) async {
    try {
      await _taskRepository.insertTask(
        UiLayerMapper.toDomainTaskModel(taskDraft),
      );
      print('Task Added');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
