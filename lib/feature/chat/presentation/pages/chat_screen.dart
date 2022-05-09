import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messaging/app/shared/assets.dart';
import 'package:messaging/app/shared/colors.dart';
import 'package:messaging/app/shared/fonts.dart';
import 'package:messaging/app/shared/ui_helpers.dart';
import 'package:messaging/app/view/base_view.dart';
import 'package:messaging/app/widget/touchables/touchable_opacity.dart';
import 'package:messaging/feature/auth/data/model/user_model.dart';
import 'package:messaging/feature/chat/data/model/messages_model.dart';
import 'package:messaging/feature/chat/presentation/provider/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseView<ChatProvider>(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: const Color(0xffFDFEFF),
          body: StreamBuilder<List<Message>>(
            stream: model.getMessages(widget.user.id),
            builder: (context, chats) {
              final data = chats.data ?? [];

              return SafeArea(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.blueColor,
                            ),
                          ),
                          gapSmall,
                          TextBold(
                            widget.user.name,
                            fontSize: 17,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppAsset.background),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: ListView.builder(
                          reverse: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) => Chatbubble(
                            message: data[index],
                            isMe: data[index].sender.id == model.user!.id,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.primaryTextColor,
                              ),
                              controller: messageController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type something',
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.secondaryTextColor2,
                                ),
                                contentPadding: EdgeInsets.only(bottom: 10),
                              ),
                            ),
                          ),
                          TouchableOpacity(
                            onTap: () async {
                              if (messageController.text.trim().isNotEmpty) {
                                await model.sendMessage(
                                  reciever: widget.user,
                                  text: messageController.text.trim(),
                                );
                                messageController.text = '';
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1),
                                color: AppColors.blueColor,
                              ),
                              child: Center(
                                child: SvgPicture.asset(AppAsset.sendd),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class Chatbubble extends StatelessWidget {
  const Chatbubble({
    Key? key,
    this.isMe = true,
    required this.message,
  }) : super(key: key);
  final bool isMe;
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 50, maxWidth: 300),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: isMe
                  ? AppColors.blueColor
                  : const Color.fromRGBO(0, 0, 0, 0.06),
            ),
            child: TextRegular(
              message.text,
              fontSize: 17,
              color: isMe ? Colors.white : const Color(0xff19232C),
            ),
          ),
        ],
      ),
    );
  }
}
