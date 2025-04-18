import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import '../model/tables.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  static QueryExecutor openStorageDatabase() {
    return driftDatabase(
      name: 'tasks_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}

