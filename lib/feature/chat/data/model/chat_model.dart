import 'package:messaging/feature/auth/data/model/user_model.dart';
import 'package:messaging/feature/chat/data/model/messages_model.dart';

class ChatModel {
  ChatModel({
    required this.message,
    required this.reciever,
    required this.time,
  });

  final String time;
  final UserModel reciever;
  final Message message;
}
