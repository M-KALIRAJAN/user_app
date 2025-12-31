import 'package:flutter/material.dart';
import 'package:nadi_user_app/core/constants/app_consts.dart';
import 'package:nadi_user_app/views/screens/chats_view.dart';
import 'package:nadi_user_app/views/screens/my_service_request.dart';
import 'package:nadi_user_app/views/screens/myprofile.dart';
import 'package:nadi_user_app/views/screens/settings_view.dart';
import 'package:nadi_user_app/widgets/HomeTabNavigator .dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  DateTime? lastBackPressed;

  final homeNavigatorKey = GlobalKey<NavigatorState>();
  late final List<Widget Function()> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      () => HomeTabNavigator(
            navigatorKey: homeNavigatorKey,
            onTabChange: changeTab,
          ),
      () => MyServiceRequest(),
      () => ChatsView(),
      () => Myprofile(),
      () => SettingsView(),
    ];
  }

  void changeTab(int index) {
    setState(() => _selectedIndex = index);
  }

  /// 🔙 BACK BUTTON HANDLER (Instagram style)
  Future<bool> _onWillPop() async {
    //  If not on Home tab → go to Home
    if (_selectedIndex != 0) {
      setState(() => _selectedIndex = 0);
      return false;
    }

    //  If Home has inner pages → pop them
    if (homeNavigatorKey.currentState != null &&
        homeNavigatorKey.currentState!.canPop()) {
      homeNavigatorKey.currentState!.pop();
      return false;
    }

    //  Dashboard root → double tap to exit
    DateTime now = DateTime.now();
    if (lastBackPressed == null ||
        now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
      lastBackPressed = now;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tap again to exit"),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }

    return true; // ✅ Exit app
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // ✅ IMPORTANT
      child: Scaffold(
        body: screens[_selectedIndex](),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF0F7757),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/icons/services.png")),
              label: "Service",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/icons/chat.png")),
              label: "Live Chat",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/icons/profile.png")),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/icons/setting.png")),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
