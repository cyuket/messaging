import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:messaging/core/errors/errors.dart';
import 'package:messaging/core/usecase/usecase.dart';
import 'package:messaging/feature/chat/data/model/messages_model.dart';
import 'package:messaging/feature/chat/domain/repository/chat_repository.dart';

@lazySingleton
class SendMessageUseCase extends UseCase<void, SendMessageUseCaseParam> {
  SendMessageUseCase({
    required this.dataRepository,
  });

  final ChatRepository dataRepository;

  @override
  Future<Either<Failure, void>> call(SendMessageUseCaseParam params) {
    return dataRepository.sendMessage(
      user: params.user,
      message: params.message,
    );
  }
}

class SendMessageUseCaseParam extends Equatable {
  const SendMessageUseCaseParam({
    required this.message,
    required this.user,
  });

  final String user;
  final Message message;

  @override
  List<Object?> get props => [
        user,
        message,
      ];
}
