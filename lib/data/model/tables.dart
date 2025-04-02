import 'package:drift/drift.dart';

// Schema for tables

class Tasks extends Table {
  late final Column<int> id = integer().autoIncrement()();
  late final Column<String> title = text()();
  late final Column<String> description = text().nullable()();
  late final Column<int> isComplete =
      integer().withDefault(const Constant(0)).check(isComplete.isIn([0, 1]))();
  late final Column<int> isFavourite =
      integer()
          .withDefault(const Constant(0))
          .check(isFavourite.isIn([0, 1]))();
  late final Column<DateTime> dueDate = dateTime().nullable()();
}
