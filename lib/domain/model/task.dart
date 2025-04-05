class Task {
  final int id;
  final String title;
  final String? description;
  final int isComplete;
  final int isFavoruite;
  final DateTime? dueDate;

  const Task({
    required this.id,
    required this.title,
    this.description,
    this.isComplete = 0,
    this.isFavoruite = 0,
    this.dueDate,
  });
}
