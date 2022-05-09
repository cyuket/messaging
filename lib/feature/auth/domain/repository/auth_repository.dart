import 'package:dartz/dartz.dart';
import 'package:messaging/core/errors/errors.dart';
import 'package:messaging/feature/auth/data/model/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserModel>> create({
    required String email,
    required String name,
    required String password,
  });
  Stream<List<UserModel>> allUsers();
}
