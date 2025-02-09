import 'package:injectable/injectable.dart';
import 'package:task_management_app/domain/home/imp_home_repo.dart';

@LazySingleton(as: ImpHomeRepository)
class HomeRepo extends ImpHomeRepository {}
