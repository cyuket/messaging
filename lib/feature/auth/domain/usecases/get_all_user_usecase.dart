import 'package:injectable/injectable.dart';
import 'package:messaging/feature/auth/data/model/user_model.dart';
import 'package:messaging/feature/auth/domain/repository/auth_repository.dart';

@lazySingleton
class GetAllUserUseCase {
  GetAllUserUseCase({
    required this.dataRepository,
  });

  final AuthRepository dataRepository;

  Stream<List<UserModel>> call() {
    return dataRepository.allUsers();
  }
}
