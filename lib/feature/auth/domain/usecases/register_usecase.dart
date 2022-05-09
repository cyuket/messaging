import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:messaging/core/errors/errors.dart';
import 'package:messaging/core/usecase/usecase.dart';
import 'package:messaging/feature/auth/data/model/user_model.dart';
import 'package:messaging/feature/auth/domain/repository/auth_repository.dart';

@lazySingleton
class RegisterUseCase extends UseCase<UserModel, RegisterUseCaseParam> {
  RegisterUseCase({
    required this.dataRepository,
  });

  final AuthRepository dataRepository;

  @override
  Future<Either<Failure, UserModel>> call(RegisterUseCaseParam params) {
    return dataRepository.create(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

class RegisterUseCaseParam extends Equatable {
  const RegisterUseCaseParam({
    required this.email,
    required this.password,
    required this.name,
  });

  final String email;
  final String password;
  final String name;

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
