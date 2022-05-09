import 'package:injectable/injectable.dart';
import 'package:messaging/feature/chat/data/model/chat_model.dart';
import 'package:messaging/feature/chat/domain/repository/chat_repository.dart';

@lazySingleton
class GetChatsUseCase {
  GetChatsUseCase({
    required this.dataRepository,
  });

  final ChatRepository dataRepository;

  Stream<List<ChatModel>> call() {
    return dataRepository.getChats();
  }
}
