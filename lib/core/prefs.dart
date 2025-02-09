// Dart imports:
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:task_management_app/domain/home/task_entity.dart';
import 'package:task_management_app/injection/injection.dart';
import 'package:task_management_app/utils/logger.dart';

class AppPrefs {
  final StreamingSharedPreferences preferences;

  AppPrefs(
    this.preferences,
  )   : token = preferences.getString(
          PrefsConstants.token,
          defaultValue: '',
        ),
        firstName = preferences.getString(
          PrefsConstants.firstName,
          defaultValue: '',
        ),
        gender = preferences.getString(
          PrefsConstants.gender,
          defaultValue: '',
        ),
        location = preferences.getString(
          PrefsConstants.location,
          defaultValue: '',
        ),
        status = preferences.getString(
          PrefsConstants.status,
          defaultValue: '',
        ),
        phoneNumber = preferences.getString(
          PrefsConstants.phoneNumber,
          defaultValue: '',
        ),
        lastName = preferences.getString(
          PrefsConstants.lastName,
          defaultValue: '',
        ),
        age = preferences.getString(
          PrefsConstants.age,
          defaultValue: '',
        ),
        loginTimestamp = preferences.getInt(
          PrefsConstants.age,
          defaultValue: 0,
        ),
        email = preferences.getString(
          PrefsConstants.email,
          defaultValue: '',
        );

  Preference<String> token;
  Preference<String> gender;
  Preference<String> firstName;
  Preference<String> phoneNumber;
  Preference<String> lastName;
  Preference<String> location;
  Preference<String> email;
  Preference<String> status;
  Preference<String> age;
  Preference<int> loginTimestamp;

  Future<bool> setBool(String key, bool value) async {
    printBefore(value: value, key: key);
    return await preferences.setBool(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    printBefore(value: value, key: key);
    return await preferences.setDouble(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    printBefore(value: value, key: key);
    return await preferences.setInt(key, value);
  }

  Future<void> clear() async {
    await preferences.clear();
  }

  Future<bool> setString(String key, String value) async {
    printBefore(value: value, key: key);
    return await preferences.setString(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    printBefore(value: value, key: key);
    return await preferences.setStringList(key, value);
  }

  Future<bool> setCustomValue(
      String key, value, PreferenceAdapter<dynamic> adapter) async {
    printBefore(value: value, key: key);
    return await preferences.setCustomValue(key, value, adapter: adapter);
  }

  void printBefore({String? key, value}) =>
      log('Saving Key: $key &  value: $value');
}

class PrefsConstants {
  static const String token = 'token';
  static const String firstName = 'firstName';
  static const String gender = 'gender';
  static const String phoneNumber = 'phoneNumber';
  static const String lastName = 'lastName';
  static const String location = 'location';
  static const String status = 'status';
  static const String email = 'email';
  static const String age = 'age';
  static const String loginTimestamp = 'loginTimestamp';
}

Future<bool> _isOnline() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return !connectivityResult.contains(ConnectivityResult.none);
}

/// Making AppPrefs injectable
Future<void> setupLocator() async {
  final preferences = await StreamingSharedPreferences.instance;
  getIt.registerLazySingleton<AppPrefs>(() => AppPrefs(preferences));
  await Hive.initFlutter();
  Hive.registerAdapter(TaskEntityAdapter());
  await Hive.openBox<TaskEntity>('tasks');
  if (await _isOnline()) {
    await Firebase.initializeApp();
  }
  logger.w("Registering App Router");
  logger.w("Registerd App Router");
}
