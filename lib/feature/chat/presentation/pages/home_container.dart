import 'package:flutter/material.dart';
import 'package:messaging/app/shared/assets.dart';
import 'package:messaging/app/shared/colors.dart';
import 'package:messaging/feature/chat/presentation/pages/all_chat.dart';
import 'package:messaging/feature/chat/presentation/pages/all_people_page.dart';
import 'package:messaging/feature/chat/presentation/pages/navbar_widget.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key, this.params}) : super(key: key);
  final HomeContainerParams? params;
  @override
  HomeContainerState createState() => HomeContainerState();
}

class HomeContainerState extends State<HomeContainer> {
  late int _selectedIndex;
  Widget? child;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    setState(() {
      if (widget.params == null) {
        _selectedIndex = 0;
        child = null;
      } else {
        _selectedIndex = widget.params!.index;
        child = widget.params!.child;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _widgetOptions = <Widget>[
      const AllChat(),
      const AllPeople(),
      Container(),
    ];
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(
          _selectedIndex,
        ),
      ),
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.white,
        selectedColor: AppColors.primaryTextColor,
        notchedShape: const CircularNotchedRectangle(),
        onTabSelected: _onItemTapped,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        centerItemText: '',
        items: [
          FABBottomAppBarItem(
            icon: AppAsset.chat,
            text: '',
          ),
          FABBottomAppBarItem(
            icon: AppAsset.people,
            text: '',
          ),
          FABBottomAppBarItem(
            icon: AppAsset.setting,
            text: '',
          ),
        ],
      ),
    );
  }
}

class HomeContainerParams {
  HomeContainerParams({this.child, required this.index});

  final int index;
  final Widget? child;
}
