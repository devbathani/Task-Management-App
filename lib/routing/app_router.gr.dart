// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:task_management_app/domain/home/task_entity.dart' as _i5;
import 'package:task_management_app/presentation/home/home_screen.dart' as _i2;
import 'package:task_management_app/presentation/task/add_task_screen.dart'
    as _i1;

/// generated route for
/// [_i1.AddTaskScreen]
class AddTaskRoute extends _i3.PageRouteInfo<AddTaskRouteArgs> {
  AddTaskRoute({
    _i4.Key? key,
    _i5.TaskEntity? taskData,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          AddTaskRoute.name,
          args: AddTaskRouteArgs(
            key: key,
            taskData: taskData,
          ),
          initialChildren: children,
        );

  static const String name = 'AddTaskRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<AddTaskRouteArgs>(orElse: () => const AddTaskRouteArgs());
      return _i1.AddTaskScreen(
        key: args.key,
        taskData: args.taskData,
      );
    },
  );
}

class AddTaskRouteArgs {
  const AddTaskRouteArgs({
    this.key,
    this.taskData,
  });

  final _i4.Key? key;

  final _i5.TaskEntity? taskData;

  @override
  String toString() {
    return 'AddTaskRouteArgs{key: $key, taskData: $taskData}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}
