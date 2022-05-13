
import 'package:hive/hive.dart';
part 'task_list.g.dart';

@HiveType(typeId: 50)
class TaskList extends HiveObject{
  @HiveField(0)
  String date;
  @HiveField(1)
  String name;
  @HiveField(2)
  String note;
  @HiveField(3)
  bool finished;
  @HiveField(4)
  int listId;

  TaskList({
    required this.name,
    required this.note,
    required this.date,
    required this.finished,
    required this.listId,
  });
}
