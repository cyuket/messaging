import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:messaging/app/shared/assets.dart';
import 'package:messaging/app/shared/fonts.dart';
import 'package:messaging/app/shared/ui_helpers.dart';
import 'package:messaging/app/view/base_view.dart';
import 'package:messaging/app/widget/input_field.dart';
import 'package:messaging/app/widget/touchables/touchable_opacity.dart';
import 'package:messaging/core/navigators/routes.dart';
import 'package:messaging/feature/auth/data/model/user_model.dart';
import 'package:messaging/feature/auth/presentation/provider/auth_provider.dart';

class AllPeople extends StatelessWidget {
  const AllPeople({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BaseView<AuthProvider>(
        builder: (context, model, child) {
          return StreamBuilder<List<UserModel>>(
            stream: model.getUsers(),
            builder: (context, users) {
              final data = users.data ?? [];
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
                            'People',
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
                          itemBuilder: (context, index) => PeopleWidget(
                            user: data[index],
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

class PeopleWidget extends StatelessWidget {
  const PeopleWidget({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TouchableOpacity(
        onTap: () =>
            Navigator.pushNamed(context, Routes.chatScreen, arguments: user),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
            ),
            gapSmall,
            Expanded(
              child: TextRegular(
                user.name,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
