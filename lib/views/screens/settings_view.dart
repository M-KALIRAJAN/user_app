import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mannai_user_app/core/constants/app_consts.dart';
import 'package:mannai_user_app/providers/theme_provider.dart';
import 'package:mannai_user_app/widgets/app_back.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  bool isToggleOn = false;

  // Reusable theme selector
  Widget themeOption(String type) {
    final currentTheme = ref.watch(themeProvider);

    bool isActive = false;

    if (type == "Light" && currentTheme == ThemeMode.light) {
      isActive = true;
    } else if (type == "Dark" && currentTheme == ThemeMode.dark) {
      isActive = true;
    } else if (type == "System" && currentTheme == ThemeMode.system) {
      isActive = true;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isActive
            ? const Color.fromRGBO(13, 95, 72, 1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        type,
        style: TextStyle(
          fontSize: 12,
          color: isActive ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget settingItem({
    required String text,
    required Image icon,
    required VoidCallback onTap,
    bool showArrow = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromRGBO(76, 149, 129, 0.3),
                ),
                child: Padding(padding: const EdgeInsets.all(10), child: icon),
              ),
              const SizedBox(width: 15),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_clr,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppCircleIconButton(
                    icon: Icons.arrow_back,
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Settings",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
            ),

            const Divider(),
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    settingItem(
                      text: "About App",
                      icon: Image.asset("assets/icons/i.png"),
                      onTap: () {},
                    ),
                    const SizedBox(height: 15),
                    settingItem(
                      text: "Help & Support",
                      icon: Image.asset("assets/icons/help.png"),
                      onTap: () {},
                    ),
                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color.fromRGBO(76, 149, 129, 0.3),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset("assets/icons/noti.png"),
                              ),
                            ),
                            const SizedBox(width: 15),
                            const Text(
                              "Notification",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => setState(() => isToggleOn = !isToggleOn),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 45,
                            height: 25,
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              color: isToggleOn
                                  ? AppColors.btn_primery
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: AnimatedAlign(
                              duration: const Duration(milliseconds: 200),
                              alignment: isToggleOn
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    settingItem(
                      text: "Change Language",
                      icon: Image.asset("assets/icons/global.png"),
                      onTap: () {},
                    ),
                    const SizedBox(height: 15),
                    settingItem(
                      text: "History",
                      icon: Image.asset("assets/icons/menu.png"),
                      onTap: () {},
                    ),
                    const SizedBox(height: 15),
                    settingItem(
                      text: "Privacy Policy",
                      icon: Image.asset("assets/icons/policy.png"),
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromRGBO(76, 149, 129, 0.3),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset("assets/icons/idea.png"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Theme",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromRGBO(178, 209, 202, 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(themeProvider.notifier)
                                      .changeTheme(ThemeMode.light);
                                  ;
                                },
                                child: themeOption("Light"),
                              ),
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(themeProvider.notifier)
                                      .changeTheme(ThemeMode.dark);
                                },
                                child: themeOption("Dark"),
                              ),
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(themeProvider.notifier)
                                      .changeTheme(ThemeMode.system);
                                },
                                child: themeOption("System"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: settingItem(
                  text: "Log Out",
                  icon: Image.asset("assets/icons/logout.png"),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// Replace Container background -  color: Theme.of(context).colorScheme.surface, // ✅ surface adapts to light/dark
// Use theme for Text -    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                  //   fontWeight: FontWeight.w600,
                                                    //   fontSize: 20,
                                                                 // ),
// textTheme.titleLarge automatically adapts to light / dark mode text color

