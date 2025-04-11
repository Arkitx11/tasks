import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/data/database/database.dart';
import 'package:tasks/data/repositories/task_repository.dart';
import 'package:tasks/data/services/database_service.dart';
import 'package:tasks/ui/task_screen.dart';
import 'package:tasks/ui/task_view_model.dart';

void main() {
  runApp(
     MultiProvider(
      providers: [
        Provider(create: (_) => AppDatabase(AppDatabase.openStorageDatabase())),
        Provider(create: (context) => DatabaseService(database: context.read())),
         Provider(create: (context) => TaskRepository(localDataService: context.read()),),
         Provider(create: (context) => TaskViewModel(taskRepository: context.read()))
      ],
      child: TaskApp(),
    ),
  );
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const TaskScreen(),
    );
  }
}
