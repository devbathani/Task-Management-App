import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:task_management_app/domain/home/imp_home_repo.dart';
import 'package:task_management_app/domain/home/task_entity.dart';
import 'package:task_management_app/routing/app_router.gr.dart';
import 'package:task_management_app/utils/color.dart';
import 'package:task_management_app/utils/logger.dart';
import 'package:task_management_app/utils/toast.dart';

enum HomeState { loading, success, idle }

@injectable
class HomeProvider extends ChangeNotifier {
  ImpHomeRepository repo;

  HomeProvider(this.repo) {
    _initFirebaseIfNeeded(); // ✅ Initialize only when online
  }

  HomeState homeStates = HomeState.idle;

  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  FirebaseFirestore? _firestore;
  List<TaskEntity> taskList = [];
  late Box<TaskEntity> _taskBox; // Hive Box for local storage
  bool needToUpdate = false;

  /// ✅ Initialize Firebase only if online
  Future<void> _initFirebaseIfNeeded() async {
    if (await _isOnline()) {
      _firestore = FirebaseFirestore.instance;
      logger.i("Firebase initialized");
    } else {
      logger.e("No internet, Firebase not initialized");
    }
  }

  Future<void> loadTasks() async {
    homeStates = HomeState.loading;
    notifyListeners();

    _taskBox = await Hive.openBox<TaskEntity>('tasks');
    taskList = _taskBox.values.toList();

    if (await _isOnline()) {
      _firestore ??= FirebaseFirestore.instance;
      final firebaseTasksSnapshot = await _firestore!.collection('tasks').get();

      List<TaskEntity> firebaseTasks = firebaseTasksSnapshot.docs.map((doc) {
        final data = doc.data();
        return TaskEntity(
          id: int.parse(doc.id),
          taskName: data['taskName'],
          taskDescription: data['taskDescription'],
          createdAt: DateTime.parse(data['createdAt']),
        );
      }).toList();

      // ✅ Compare and Merge: Remove duplicates & Check if Hive has extra data
      Set<int> firebaseTaskIds = firebaseTasks.map((task) => task.id).toSet();
      Set<int> hiveTaskIds = taskList.map((task) => task.id).toSet();

      // Remove duplicates by keeping only unique tasks from Hive
      taskList.removeWhere((task) => firebaseTaskIds.contains(task.id));

      // If Hive has extra tasks not in Firebase, set needToUpdate = true
      needToUpdate = hiveTaskIds.difference(firebaseTaskIds).isNotEmpty;

      // Merge both lists (keeping Hive tasks first)
      taskList = [...taskList, ...firebaseTasks];
    }

    homeStates = HomeState.success;
    notifyListeners();
    logger.i("Tasks loaded. Need to update Firebase: $needToUpdate");
  }

  /// ✅ Add Task to Hive & Firestore (if online)
  Future<void> addTask(BuildContext context) async {
    homeStates = HomeState.loading;
    notifyListeners();

    final task = TaskEntity(
      id: DateTime.now().millisecondsSinceEpoch.remainder(0xFFFFFFFF),
      taskName: taskNameController.text,
      taskDescription: taskDescriptionController.text,
      createdAt: DateTime.now(),
    );

    // Save locally in Hive
    await _taskBox.put(task.id, task);
    taskList.add(task);

    if (await _isOnline()) {
      await _firestore!.collection('tasks').doc(task.id.toString()).set({
        'id': task.id,
        'taskName': task.taskName,
        'taskDescription': task.taskDescription,
        'createdAt': task.createdAt.toIso8601String(),
      });
    }
    taskNameController.clear();
    taskDescriptionController.clear();
    if (context.mounted) {
      AutoRouter.of(context).pushAndPopUntil(
        HomeRoute(),
        predicate: (route) => false,
      );
    }

    loadTasks();
    homeStates = HomeState.success;
    notifyListeners();
    logger.i("Task added: ${task.taskName}");
  }

  /// ✅ Edit Task in Hive & Firestore (if online)
  Future<void> editTask(int taskId, String newName, String newDescription,
      BuildContext context) async {
    homeStates = HomeState.loading;
    notifyListeners();

    final taskIndex = taskList.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      taskList[taskIndex].taskName = newName;
      taskList[taskIndex].taskDescription = newDescription;

      await _taskBox.put(taskId, taskList[taskIndex]);
      print(taskId);
      print(newName);
      print(newDescription);
      if (await _isOnline()) {
        await _firestore!.collection('tasks').doc(taskId.toString()).update({
          'taskName': newName,
          'taskDescription': newDescription,
        });
      }
      taskNameController.clear();
      taskDescriptionController.clear();
      if (context.mounted) {
        AutoRouter.of(context).pushAndPopUntil(
          HomeRoute(),
          predicate: (route) => false,
        );
      }
      homeStates = HomeState.success;
      notifyListeners();
      logger.i("Task updated: $newName");
    }
  }

  /// ✅ Delete Task from Hive & Firestore (if online)
  Future<void> deleteTask(int taskId) async {
    homeStates = HomeState.loading;
    notifyListeners();

    await _taskBox.delete(taskId);
    taskList.removeWhere((task) => task.id == taskId);

    if (await _isOnline()) {
      await _firestore!.collection('tasks').doc(taskId.toString()).delete();
    }

    homeStates = HomeState.success;
    notifyListeners();
    logger.i("Task deleted: $taskId");
  }

  /// ✅ Sync Now - Push Hive Data to Firestore (Avoiding Duplicates)
  Future<void> syncDataToFirebase() async {
    homeStates = HomeState.loading;
    notifyListeners();

    if (await _isOnline()) {
      if (taskList.isEmpty) {
        showToast("Please add task to sync", redColor);
      } else {
        for (var task in taskList) {
          final taskRef =
              _firestore!.collection('tasks').doc(task.id.toString());

          // 🔍 Check if the task already exists in Firestore
          final docSnapshot = await taskRef.get();
          if (!docSnapshot.exists) {
            // 🚀 Task doesn't exist, add to Firestore
            await taskRef.set({
              'id': task.id,
              'taskName': task.taskName,
              'taskDescription': task.taskDescription,
              'createdAt': task.createdAt.toIso8601String(),
            });
          }
          showToast("Data synced", greenColor);
        }
      }
      homeStates = HomeState.success;
      needToUpdate = false;

      notifyListeners();
      logger.i("All local tasks synced to Firebase.");
    } else {
      homeStates = HomeState.success;
      showToast("No internet connection. Sync failed.", redColor);
      logger.e("No internet connection. Sync failed.");
    }
  }

  /// ✅ Check Internet Connectivity
  Future<bool> _isOnline() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }

  void updateController(String taskName, String taskDescription) {
    taskNameController.text = taskName;
    taskDescriptionController.text = taskDescription;
    notifyListeners();
  }
}
