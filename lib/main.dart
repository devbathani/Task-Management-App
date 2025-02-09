import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/core/prefs.dart';
import 'package:task_management_app/injection/injection.dart';
import 'package:task_management_app/providers/provider.dart';
import 'package:task_management_app/routing/app_router.dart';

void main() async {
  configureInjection(Environment.test);
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: MediaQuery.sizeOf(context).width > 600
          ? const Size(800, 1280)
          : const Size(375, 812),
      minTextAdapt: true,
      child: MultiProvider(
        providers: List.from(providers),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          title: "Acme Solutions",
        ),
      ),
    );
  }
}
