import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/ui/detail_task_screen.dart';
import 'package:tasks/ui/task_draft.dart';
import 'package:tasks/ui/task_view_model.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks'), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return TaskModalSheet();
            },
          );
        },
        icon: Icon(Icons.add),
        label: Text('Add a Task'),
      ),
      body: TaskScreenBody(),
    );
  }
}
// TODO(feat): Add warning dialog for discarding filled modal
class TaskModalSheet extends StatefulWidget {
  const TaskModalSheet({super.key});

  @override
  State<TaskModalSheet> createState() => _TaskModalSheetState();
}

class _TaskModalSheetState extends State<TaskModalSheet> {
  bool showDescriptionField = false;
  final TaskDraft _taskDraft = TaskDraft();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                onChanged: (value) => _taskDraft.title = value,
                autofocus: true,
                decoration: InputDecoration(labelText: 'Task'),
              ),
            ),
            (showDescriptionField)
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Description'),
                    onChanged: (value) => _taskDraft.description = value,
                  ),
                )
                : SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // TODO: Combine DatePicker and TimePicker in a single icon
                  IconButton(
                    onPressed: () {
                      setState(() {
                        showDescriptionField = !showDescriptionField;
                      });
                    },
                    icon: Icon(Icons.description),
                  ),
                  IconButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                        ),
                        lastDate: DateTime(
                          DateTime.now().year + 1,
                          DateTime.now().month + 1,
                          DateTime.now().day + 1,
                        ),
                      );
                      _taskDraft.selectedDate = date;
                    },
                    icon: Icon(Icons.date_range),
                  ),
                  IconButton(
                    onPressed: () async {
                      _taskDraft.selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                    },
                    icon: Icon(Icons.access_time_filled),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _taskDraft.isFavourite = !_taskDraft.isFavourite;
                      });
                    },
                    icon: Icon(
                      (!_taskDraft.isFavourite)
                          ? Icons.star_border
                          : Icons.star,
                    ),
                  ),
                  Spacer(flex: 1),
                  // TODO(feat): refactor to make UI reactive to operation error (Result<T> or Enum)
                  // TODO(feat): Disable button if the text field is empty
                  ElevatedButton(
                    onPressed: () {
                      context.read<TaskViewModel>().onPressingSave(_taskDraft);
                      Navigator.pop(context);
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskScreenBody extends StatelessWidget {
  const TaskScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context);
    return StreamBuilder(
      stream: viewModel.taskList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const CircularProgressIndicator());
        } else if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return Center(child: Text('Error Fetching Task'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Tasks Yet'));
        } else {
          final taskList = snapshot.data;
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final task = taskList![index];
              return ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailTaskScreen(task: task)));
                },
                title: Text(task.title),
                leading: IconButton(
                  onPressed: () {
                    viewModel.onTaskCompletion(task);
                  },
                  icon: Icon(Icons.radio_button_unchecked),
                ),
              );
            },
          );
        }
      },
    );
  }
}
