// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:task_management_app/domain/home/imp_home_repo.dart' as _i112;
import 'package:task_management_app/infrastructure/home/home_repository.dart'
    as _i51;
import 'package:task_management_app/providers/home/home_provider.dart' as _i762;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i112.ImpHomeRepository>(() => _i51.HomeRepo());
    gh.factory<_i762.HomeProvider>(
        () => _i762.HomeProvider(gh<_i112.ImpHomeRepository>()));
    return this;
  }
}
