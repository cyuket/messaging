import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:messaging/core/errors/error.dart';
import 'package:messaging/core/errors/network_info.dart';
import 'package:messaging/feature/auth/data/model/user_model.dart';
import 'package:messaging/feature/chat/data/model/chat_model.dart';
import 'package:messaging/feature/chat/data/model/messages_model.dart';

abstract class ChatRemoteDataSource {
  Future<void> sendMessage({required String user, required Message message});
  Stream<List<Message>> getMessages(String userId);
  Stream<List<ChatModel>> getChats();
}

@LazySingleton(as: ChatRemoteDataSource)
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl({
    required this.networkInfo,
  });
  final NetworkInfo networkInfo;

  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference get messagesCollection =>
      FirebaseFirestore.instance.collection('messages');

  @override
  Future<void> sendMessage({
    required String user,
    required Message message,
  }) async {
    print(
      message.toJson(),
    );
    if (await networkInfo.isConnected) {
      final data = <String, dynamic>{
        'time': message.time,
        'reciever': message.receiver.toJson(),
        'sender': message.sender.toJson(),
        'message': message.toJson(),
        'chatId': getChatNode(
          auth.currentUser!.uid,
          user,
        ),
      };
      final id = getChatNode(
        auth.currentUser!.uid,
        user,
      );

      await messagesCollection.doc(id).set(
            data,
            SetOptions(merge: true),
          );
      await messagesCollection.doc(id).collection('chats').doc().set(
            message.toJson(),
          );
    } else {
      throw NoInternetException();
    }
  }

  @override
  Stream<List<Message>> getMessages(String userId) {
    final transformer =
        StreamTransformer<QuerySnapshot, List<Message>>.fromHandlers(
      handleData: (QuerySnapshot snaps, EventSink<List<Message>> out) async {
        final list = <Message>[];

        for (final snap in snaps.docs) {
          final messsage = Message.fromJson(snap.data());
          list.add(messsage);
        }
        out.add(list);
      },
    );

    return messagesCollection
        .doc(
          getChatNode(
            auth.currentUser!.uid,
            userId,
          ),
        )
        .collection('chats')
        .orderBy('time', descending: true)
        .snapshots()
        .transform(transformer);
  }

  String getChatNode(String sender, String receiver) {
    if (sender.hashCode <= receiver.hashCode) {
      return '$sender-$receiver';
    } else {
      return '$receiver-$sender';
    }
  }

  @override
  Stream<List<ChatModel>> getChats() {
    final transformer =
        StreamTransformer<QuerySnapshot, List<ChatModel>>.fromHandlers(
      handleData: (QuerySnapshot snaps, EventSink<List<ChatModel>> out) async {
        final list = <ChatModel>[];

        for (final snap in snaps.docs) {
          late UserModel user;
          final data = snap.data();
          final chatId = data['chatId'] as String;

          if (chatId.contains(auth.currentUser!.uid)) {
            if (data['sender']['id'] == auth.currentUser!.uid) {
              user = UserModel.fromJson(data['reciever']);
            } else {
              user = UserModel.fromJson(data['sender']);
            }
            final chat = ChatModel(
              message: Message.fromJson(data['message']),
              reciever: user,
              time: data['time'],
            );
            list.add(chat);
          }
        }
        out.add(list);
      },
    );

    return messagesCollection
        .orderBy('time', descending: true)
        .snapshots()
        .transform(transformer);
  }
}
