// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/auth/auth_local_data_source.dart' as _i878;
import '../../data/auth/auth_remote_data_source.dart' as _i666;
import '../../data/auth_repo_impl.dart' as _i446;
import '../../domain/auth/auth_repository.dart' as _i937;
import '../../features/auth/login_cubit.dart' as _i915;
import '../../features/products/viwemodel/create_product_cubit.dart' as _i383;
import 'app_module.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i383.CreateProductCubit>(() => _i383.CreateProductCubit());
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => appModule.provideSharedPreferences(),
      preResolve: true,
    );
    gh.lazySingleton<_i361.BaseOptions>(() => appModule.provideBaseOptions());
    gh.factory<_i878.AuthLocalDataSource>(
      () => _i878.AuthLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => appModule.provideDio(gh<_i361.BaseOptions>()),
    );
    gh.factory<_i666.AuthRemoteDataSource>(
      () => _i666.AuthRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.factory<_i937.AuthRepository>(
      () => _i446.AuthRepoImpl(
        gh<_i666.AuthRemoteDataSource>(),
        gh<_i878.AuthLocalDataSource>(),
      ),
    );
    gh.factory<_i915.LoginCubit>(
      () => _i915.LoginCubit(gh<_i937.AuthRepository>()),
    );
    return this;
  }
}

class _$AppModule extends _i460.AppModule {}
