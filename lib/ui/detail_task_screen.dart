import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/domain/model/task.dart';
import 'package:tasks/ui/task_view_model.dart';

class DetailTaskScreen extends StatelessWidget {
  final Task task;

  const DetailTaskScreen({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    final onTaskDeletion = Provider.of<TaskViewModel>(context).onTaskCompletion;
    print(task.id!);
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
        actions: [
          IconButton(
            onPressed: () {
              onTaskDeletion(task);
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.0,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(task.description ?? ''),
            Text((task.isFavoruite == 1) ? 'Favourite' : 'Unfavourite' ),
            if (task.dateTime != null) Text(task.dateTime!.toIso8601String()),
          ],
        ),
      ),
    );
  }
}
