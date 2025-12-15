import 'package:flutter/material.dart';
import 'package:mannai_user_app/core/constants/app_consts.dart';
import 'package:mannai_user_app/views/screens/chats_view.dart';
import 'package:mannai_user_app/views/screens/my_service_request.dart';
import 'package:mannai_user_app/views/screens/myprofile.dart';
import 'package:mannai_user_app/views/screens/settings_view.dart';
import 'package:mannai_user_app/widgets/HomeTabNavigator%20.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final List<Widget> screens;
  final homeNavigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screens = [
      HomeTabNavigator(navigatorKey: homeNavigatorKey, onTabChange: changeTab),
      MyServiceRequest(),
      ChatsView(),
      Myprofile(),
      SettingsView(),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        // IMPORTANT
        index: _selectedIndex,
        children: screens,
      ),
    
      bottomNavigationBar: Container(
        height: 85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
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
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: Colors.white,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
    
            selectedItemColor: Color(0xFF0F7757),
            unselectedItemColor: Colors.grey,
    
            selectedLabelStyle: const TextStyle(fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
    
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: ImageIcon(
                  AssetImage("assets/icons/home.png"),
                  size: 26,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/services.png"),
                  size: 28,
                ),
                activeIcon:ImageIcon(
                  AssetImage("assets/icons/services.png"),
                   color:AppColors.btn_primery,
                  size: 28,
                ),
                label: "Service",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/icons/chat.png"), size: 26),
                activeIcon:ImageIcon(AssetImage("assets/icons/chat.png"), size: 26,color:AppColors.btn_primery),
                label: "Live Chat",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/profile.png"),
                  size: 26,
                ),
                activeIcon:  ImageIcon(
                  AssetImage("assets/icons/profile.png"),
                  color:AppColors.btn_primery,
                  size: 26,
                ),
                label: "Profile",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/setting.png"),
                  size: 26,
                ),
                activeIcon: ImageIcon(
                  AssetImage("assets/icons/setting.png"),
                  color:AppColors.btn_primery,
                  size: 26,
                ),
                label: "Settings",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
