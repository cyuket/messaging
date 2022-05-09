import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:messaging/core/errors/error.dart';
import 'package:messaging/core/errors/failure.dart';
import 'package:messaging/feature/chat/data/datasources/chat_data_sources.dart';
import 'package:messaging/feature/chat/data/model/chat_model.dart';
import 'package:messaging/feature/chat/data/model/messages_model.dart';
import 'package:messaging/feature/chat/domain/repository/chat_repository.dart';

@LazySingleton(as: ChatRepository)
class AuthRepositoryImpl extends ChatRepository {
  AuthRepositoryImpl({
    required this.remoteDataSource,
  });
  final ChatRemoteDataSource remoteDataSource;

  @override
  Stream<List<Message>> getMessages(String userId) {
    return remoteDataSource.getMessages(userId);
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required String user,
    required Message message,
  }) async {
    try {
      final response =
          await remoteDataSource.sendMessage(user: user, message: message);
      return Right(response);
    } catch (e) {
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }

      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Stream<List<ChatModel>> getChats() {
    return remoteDataSource.getChats();
  }
}
