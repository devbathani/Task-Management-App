import 'package:hive/hive.dart';

part 'task_entity.g.dart';

@HiveType(typeId: 0)
class TaskEntity extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String taskName;

  @HiveField(2)
  String taskDescription;

  @HiveField(3)
  DateTime createdAt;

  TaskEntity(
      {required this.id,
      required this.taskName,
      required this.taskDescription,
      required this.createdAt});
}
