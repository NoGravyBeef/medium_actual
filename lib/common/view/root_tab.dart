import 'package:flutter/material.dart';
import 'package:medium_actual/common/const/colors.dart';
import 'package:medium_actual/common/layout/default_layout.dart';
import 'package:medium_actual/restaurant/view/restaurant_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(tabListener);
  }

  void tabListener() {
    setState(() {
      index = tabController.index;
    });
  }

  @override
  void dispose() {
    tabController.removeListener(tabListener);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        onTap: (int value) {
          tabController.animateTo(value);
          index = value;
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '프로필',
          ),
        ],
      ),
      child: SafeArea(
        top: true,
        bottom: false,
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            Center(child: RestaurantScreen()),
            Center(child: Container(child: Text('음식'))),
            Center(child: Container(child: Text('주문'))),
            Center(child: Container(child: Text('프로필'))),
          ],
        ),
      ),
    );
  }
}
