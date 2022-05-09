import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:messaging/app/shared/assets.dart';
import 'package:messaging/app/shared/colors.dart';
import 'package:messaging/app/shared/fonts.dart';
import 'package:messaging/app/shared/ui_helpers.dart';
import 'package:messaging/app/view/base_view.dart';
import 'package:messaging/app/widget/input_field.dart';
import 'package:messaging/app/widget/touchables/touchable_opacity.dart';
import 'package:messaging/core/navigators/routes.dart';
import 'package:messaging/feature/chat/data/model/chat_model.dart';
import 'package:messaging/feature/chat/presentation/provider/chat_provider.dart';

class AllChat extends StatelessWidget {
  const AllChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BaseView<ChatProvider>(
        builder: (context, model, child) {
          return StreamBuilder<List<ChatModel>>(
            stream: model.getChats(),
            builder: (context, chats) {
              final data = chats.data ?? [];
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                          ),
                          gapSmall,
                          TextBold(
                            'Chats',
                            fontSize: 30,
                          ),
                          const Spacer(),
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xffF4F5F7),
                            child: Icon(
                              Icons.camera_alt,
                              color: Color(0xff979797),
                            ),
                          ),
                          gapSmall,
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: const Color(0xffF4F5F7),
                            child: SvgPicture.asset(AppAsset.create),
                          ),
                        ],
                      ),
                      const Gap(20),
                      const InputField(
                        controller: null,
                        placeholder: 'Search',
                        noBorder: true,
                        suffix: Icon(
                          Icons.search,
                          color: Color(0xffB0B7C3),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) => ChatWidget(
                            chat: data[index],
                            isMe:
                                data[index].message.sender.id == model.user!.id,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key, required this.chat, required this.isMe})
      : super(key: key);
  final ChatModel chat;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    final time = DateFormat.jm().format(DateTime.parse(chat.time));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TouchableOpacity(
        onTap: () => Navigator.pushNamed(
          context,
          Routes.chatScreen,
          arguments: chat.reciever,
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
            ),
            gapSmall,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextRegular(
                    chat.reciever.name,
                    fontSize: 17,
                  ),
                  RichText(
                    maxLines: 1,
                    text: TextSpan(
                      style: textSpanStyle(
                        fontSize: 14,
                        color: AppColors.secondaryTextColor2,
                      ),
                      text: isMe
                          ? 'You: ${chat.message.text}  '
                          : chat.message.text,
                      children: [
                        TextSpan(text: time),
                      ],
                    ),
                  ),
                  // Row(
                ],
              ),
            ),
            gapSmall,
            if (isMe)
              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(),
                ),
                child: const Icon(
                  Icons.check,
                  size: 7,
                ),
              )
          ],
        ),
      ),
    );
  }
}
