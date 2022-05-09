import 'package:injectable/injectable.dart';
import 'package:messaging/feature/chat/data/model/messages_model.dart';
import 'package:messaging/feature/chat/domain/repository/chat_repository.dart';

@lazySingleton
class GetMessagesUseCase {
  GetMessagesUseCase({
    required this.dataRepository,
  });

  final ChatRepository dataRepository;

  Stream<List<Message>> call(String userId) {
    return dataRepository.getMessages(userId);
  }
}
