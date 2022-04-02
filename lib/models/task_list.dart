class TaskList {
  String date;
  String name;
  String note;
  bool finished;
  int listId;

  TaskList({
    required this.name,
    required this.note,
    required this.date,
    required this.finished,
    required this.listId,
  });
}
