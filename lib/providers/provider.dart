import 'package:provider/provider.dart';
import 'package:task_management_app/injection/injection.dart';
import 'package:task_management_app/providers/home/home_provider.dart';

final providers = [
  ChangeNotifierProvider<HomeProvider>(
    create: (context) => getIt<HomeProvider>(),
    lazy: false,
  ),
];
