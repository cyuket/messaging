import 'package:injectable/injectable.dart';
import 'package:messaging/app/view/view_model/base_view_model.dart';
import 'package:messaging/core/injections/injections.dart';
import 'package:messaging/feature/auth/data/model/user_model.dart';
import 'package:messaging/feature/auth/presentation/provider/auth_provider.dart';
import 'package:messaging/feature/chat/data/model/chat_model.dart';
import 'package:messaging/feature/chat/data/model/messages_model.dart';
import 'package:messaging/feature/chat/domain/usecases/get_chats_usecase.dart';
import 'package:messaging/feature/chat/domain/usecases/get_messages_use_case.dart';
import 'package:messaging/feature/chat/domain/usecases/send_message_usecase.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class ChatProvider extends BaseModel {
  ChatProvider({
    required this.sendMessageUseCase,
    required this.getMessagesUseCase,
    required this.getChatsUseCase,
  });
  final SendMessageUseCase sendMessageUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final GetChatsUseCase getChatsUseCase;
  final user = sl<AuthProvider>().user;

  Stream<List<Message>> getMessages(String userId) {
    return getMessagesUseCase(userId);
  }

  Stream<List<ChatModel>> getChats() {
    return getChatsUseCase();
  }

  Future<void> sendMessage({
    required UserModel reciever,
    required String text,
  }) async {
    setBusy(value: true);
    final id = const Uuid().v4();
    final message = Message(
      id: id,
      sender: user!,
      time: DateTime.now().toIso8601String(),
      text: text,
      receiver: reciever,
    );
    final result = sendMessageUseCase(
      SendMessageUseCaseParam(
        message: message,
        user: reciever.id,
      ),
    );
  }
}
