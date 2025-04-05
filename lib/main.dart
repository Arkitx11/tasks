import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import 'data/database/database.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();

  await database.into(database.tasks).insert(TasksCompanion.insert(
    title: 'Wake me up at 5 Am',
    dueDate: DateTime.now(),
    description: Value('Getting ready for college'), // I don't know why I wrapped it inside Value



  ));
  List<Task> allItems = await database.select(database.tasks).get();

  print('items in database: $allItems');
}