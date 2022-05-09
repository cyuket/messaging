import 'package:dartz/dartz.dart';
import 'package:messaging/core/errors/failure.dart';
import 'package:messaging/feature/chat/data/model/chat_model.dart';
import 'package:messaging/feature/chat/data/model/messages_model.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> sendMessage({
    required String user,
    required Message message,
  });
  Stream<List<Message>> getMessages(String userId);
  Stream<List<ChatModel>> getChats();
}
