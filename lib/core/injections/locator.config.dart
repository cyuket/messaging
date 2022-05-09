// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_storage/firebase_storage.dart' as _i3;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i5;

import '../../feature/auth/data/data_sources/user_data_sources.dart' as _i10;
import '../../feature/auth/data/repository/auth_repository_imp.dart' as _i12;
import '../../feature/auth/domain/repository/auth_repository.dart' as _i11;
import '../../feature/auth/domain/usecases/get_all_user_usecase.dart' as _i16;
import '../../feature/auth/domain/usecases/login_usecase.dart' as _i19;
import '../../feature/auth/domain/usecases/register_usecase.dart' as _i20;
import '../../feature/auth/presentation/provider/auth_provider.dart' as _i22;
import '../../feature/chat/data/datasources/chat_data_sources.dart' as _i13;
import '../../feature/chat/data/repository/chat_repository_impl.dart' as _i15;
import '../../feature/chat/domain/repository/chat_repository.dart' as _i14;
import '../../feature/chat/domain/usecases/get_chats_usecase.dart' as _i17;
import '../../feature/chat/domain/usecases/get_messages_use_case.dart' as _i18;
import '../../feature/chat/domain/usecases/send_message_usecase.dart' as _i21;
import '../../feature/chat/presentation/provider/chat_provider.dart' as _i23;
import '../errors/network_info.dart' as _i8;
import '../local_data/local_data_storage.dart' as _i6;
import '../navigators/navigation_service.dart' as _i7;
import '../utils/third_party_mode_env.dart' as _i9;
import 'register_module.dart' as _i24; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<_i3.FirebaseStorage>(() => registerModule.firebaseStorage);
  gh.factory<_i4.FlutterSecureStorage>(
      () => registerModule.flutterSecureStorage);
  gh.factory<_i5.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.lazySingleton<_i6.LocalDataStorage>(
      () => _i6.LocalDataStorageImpl(get<_i4.FlutterSecureStorage>()));
  gh.lazySingleton<_i7.NavigationService>(() => _i7.NavigationService());
  gh.lazySingleton<_i8.NetworkInfo>(
      () => _i8.NetworkInfoImpl(get<_i5.InternetConnectionChecker>()));
  gh.singleton<_i9.ThirdPartyModeEnv>(_i9.ThirdPartyModeEnv());
  gh.lazySingleton<_i10.UserRemoteDataSource>(
      () => _i10.UserRemoteDataSourceImpl(networkInfo: get<_i8.NetworkInfo>()));
  gh.lazySingleton<_i11.AuthRepository>(() => _i12.AuthRepositoryImpl(
      remoteDataSource: get<_i10.UserRemoteDataSource>()));
  gh.lazySingleton<_i13.ChatRemoteDataSource>(
      () => _i13.ChatRemoteDataSourceImpl(networkInfo: get<_i8.NetworkInfo>()));
  gh.lazySingleton<_i14.ChatRepository>(() => _i15.AuthRepositoryImpl(
      remoteDataSource: get<_i13.ChatRemoteDataSource>()));
  gh.lazySingleton<_i16.GetAllUserUseCase>(
      () => _i16.GetAllUserUseCase(dataRepository: get<_i11.AuthRepository>()));
  gh.lazySingleton<_i17.GetChatsUseCase>(
      () => _i17.GetChatsUseCase(dataRepository: get<_i14.ChatRepository>()));
  gh.lazySingleton<_i18.GetMessagesUseCase>(() =>
      _i18.GetMessagesUseCase(dataRepository: get<_i14.ChatRepository>()));
  gh.lazySingleton<_i19.LoginUserCase>(
      () => _i19.LoginUserCase(dataRepository: get<_i11.AuthRepository>()));
  gh.lazySingleton<_i20.RegisterUseCase>(
      () => _i20.RegisterUseCase(dataRepository: get<_i11.AuthRepository>()));
  gh.lazySingleton<_i21.SendMessageUseCase>(() =>
      _i21.SendMessageUseCase(dataRepository: get<_i14.ChatRepository>()));
  gh.lazySingleton<_i22.AuthProvider>(() => _i22.AuthProvider(
      loginUserCase: get<_i19.LoginUserCase>(),
      registerUseCase: get<_i20.RegisterUseCase>(),
      getAllUsersUseCase: get<_i16.GetAllUserUseCase>()));
  gh.lazySingleton<_i23.ChatProvider>(() => _i23.ChatProvider(
      sendMessageUseCase: get<_i21.SendMessageUseCase>(),
      getMessagesUseCase: get<_i18.GetMessagesUseCase>(),
      getChatsUseCase: get<_i17.GetChatsUseCase>()));
  return get;
}

class _$RegisterModule extends _i24.RegisterModule {}
