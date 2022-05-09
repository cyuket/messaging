// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:messaging/feature/auth/data/model/user_model.dart';

part 'messages_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Message {
  Message({
    required this.id,
    required this.sender,
    required this.time,
    required this.text,
    required this.receiver,
  });
  final String id;
  final UserModel sender;
  final UserModel receiver;
  final String time;
  final String text;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
