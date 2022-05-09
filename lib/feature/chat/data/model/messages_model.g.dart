// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as String,
      sender: UserModel.fromJson(json['sender'] as Map<String, dynamic>),
      time: json['time'] as String,
      text: json['text'] as String,
      receiver: UserModel.fromJson(json['receiver'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender.toJson(),
      'receiver': instance.receiver.toJson(),
      'time': instance.time,
      'text': instance.text,
    };
