import 'package:tasks/domain/model/task.dart';
import 'package:tasks/ui/task_draft.dart';



class UiLayerMapper {
  // TODO(Refactor): Remove the logic from mapper. A mapper shouldn't hold logic
  static Task toDomainTaskModel(TaskDraft taskDraft) {
    final DateTime? dateTime =
        (taskDraft.selectedDate != null && taskDraft.selectedTime != null)
            ? DateTime(
              taskDraft.selectedDate!.year,
              taskDraft.selectedDate!.month,
              taskDraft.selectedDate!.day,
              taskDraft.selectedTime!.hour,
              taskDraft.selectedTime!.minute,
            )
            : null;

    return Task(
      title: taskDraft.title,
      description: taskDraft.description,
      dateTime: dateTime,
      isFavoruite: (taskDraft.isFavourite) ? 1 : 0,
    );
  }
}

