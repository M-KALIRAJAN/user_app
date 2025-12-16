import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mannai_user_app/controllers/address_controller.dart';

import 'package:mannai_user_app/core/constants/app_consts.dart';
import 'package:mannai_user_app/preferences/preferences.dart';
import 'package:mannai_user_app/providers/auth_Provider.dart';
import 'package:mannai_user_app/routing/app_router.dart';
import 'package:mannai_user_app/services/auth_service.dart';
import 'package:mannai_user_app/widgets/buttons/primary_button.dart';
import 'package:mannai_user_app/widgets/inputs/app_dropdown.dart';
import 'package:mannai_user_app/widgets/inputs/app_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Address extends StatefulWidget {
  final String accountType;
  final VoidCallback? onNext;
  final bool family;
  final GlobalKey<FormState> formKey;
  final AddressController controller;
  const Address({
    super.key,
    required this.accountType,
    this.onNext,
    this.family = false,
    required this.formKey,
    required this.controller,
  });

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  String selected = "Flat";
  bool _isLoading = false;
  final AuthService _adressservice = AuthService();
  AddressController get controller => widget.controller;
  Future<void> familyAccount(BuildContext context) async {
    // final prefs = await SharedPreferences.getInstance();
    // final userId = prefs.getString("userId");
    final userId = await AppPreferences.getUserId();

    if (userId == null) {
      debugPrint("❌ USER ID IS NULL");
      return;
    }

    final body = controller.getApiAddressBody(
      userId: userId,
      addressType: selected.toLowerCase(),
    );

    debugPrint("📤 API BODY 👉 $body");

    bool showLoader = false;

    // Start a delayed timer for loader (300ms)
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!showLoader) return;
      if (mounted)
        setState(
          () => _isLoading = true,
        ); // show loader only if API is still running
    });

    try {
      showLoader = true;

      final response = await _adressservice.adressdetails(body: body);

      // API finished
      showLoader = false;
      if (mounted)
        setState(() => _isLoading = false); // hide loader if it was shown

      if (response != null) {
        debugPrint("✅ Address saved successfully");

        if (widget.accountType == "Family") {
          widget.onNext?.call();
        } else {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: const Text(
                  "Account created successfully",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: AppColors.button_secondary,
                duration: const Duration(seconds: 2),
              ),
            );

          // small delay so user can see snackbar
          Future.delayed(const Duration(seconds: 1), () {
            context.push(RouteNames.accountverfy);
          });
        }
      }
    } catch (e) {
      showLoader = false;
      if (mounted) setState(() => _isLoading = false);
      debugPrint("❌ Address submit failed 👉 $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Submit failed: $e")));
    }
  }

  Widget buildType(String type, String icon) {
    final bool isSelected = selected == type;

    return GestureDetector(
      onTap: () => setState(() => selected = type),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.btn_primery : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? null
              : Border.all(color: Colors.grey.shade400, width: 1),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 24,
              width: 24,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            SizedBox(width: 6),
            Text(
              type,
              style: TextStyle(
                fontSize: 15,
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          AppTextField(controller: controller.building, label: "Pick Location"),
          SizedBox(height: 10),

          if (widget.accountType == "Family") ...[
            AppTextField(label: "Enter Number of kids*"),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: AppTextField(label: "No of boys*")),
                SizedBox(width: 10),
                Expanded(child: AppTextField(label: "No of girls*")),
              ],
            ),
            SizedBox(height: 17),
          ],
          SizedBox(height: 15),
          Image.asset("assets/images/map.png", height: 84),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildType("Flat", 'assets/icons/Flat.png'),
              buildType("Villa", 'assets/icons/villa.png'),
              buildType("Office", 'assets/icons/office.png'),
            ],
          ),
          SizedBox(height: 17),
          AppTextField(
            controller: controller.city,
            label: "Enter Your ity/Area",
          ),
          SizedBox(height: 17),
          AppTextField(
            controller: controller.building,
            label: "Enter Your Building*",
            validator: (value) => controller.validateBuilding(value),
          ),
          SizedBox(height: 17),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: controller.aptNo,
                  label: "Enter Apt No*",
                  validator: (value) => controller.validateAptNo(value),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: AppTextField(
                  controller: controller.floor,
                  label: "Enter Floor No*",
                  validator: (value) => controller.validateFloor(value),
                ),
              ),
            ],
          ),
          SizedBox(height: 17),

          Consumer(
            builder: (context, ref, child) {
              final roadsAsync = ref.watch(getBlockProvider);

              return roadsAsync.when(
                data: (roads) {
                  final roadNames = roads
                      .map((r) => r['name'] as String)
                      .toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Road Dropdown
                      AppDropdown(
                        label: "Select Your Road*",
                        items: roadNames,
                        value: controller.road,
                        onChanged: (val) {
                          setState(() {
                            final selectedRoad = roads.firstWhere(
                              (r) => r['name'] == val,
                            );

                            controller.road = selectedRoad['name']; // ✅ name
                            controller.roadId =
                                selectedRoad['_id']; // ✅ ID FIXED

                            controller.block = null;
                            controller.blockId = null;

                            controller.blocksForSelectedRoad =
                                List<Map<String, dynamic>>.from(
                                  selectedRoad['blocks'],
                                );
                          });
                        },
                        validator: (val) =>
                            val == null ? "Please select a road" : null,
                      ),

                      SizedBox(height: 15),
                      // Block Dropdown
                      AppDropdown(
                        label: "Select Your Block*",
                        items: controller.blocksForSelectedRoad
                            .map((b) => b['name'] as String)
                            .toList(),
                        value: controller.block,
                        onChanged: (val) {
                          setState(() {
                            final selectedBlock = controller
                                .blocksForSelectedRoad
                                .firstWhere((b) => b['name'] == val);

                            controller.block = selectedBlock['name']; // name
                            controller.blockId = selectedBlock['_id']; //  id
                          });
                        },

                        validator: (val) =>
                            val == null ? "Please select a block" : null,
                      ),
                    ],
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => Text("Failed to load roads/blocks: $e"),
              );
            },
          ),

          SizedBox(height: 20),
          if (!widget.family) // If NOT coming from add member
            AppButton(
              text: widget.accountType == "Family" ? "Continue" : "Sign In",
              isLoading: _isLoading,
              onPressed: () {
                final isValid =
                    widget.formKey.currentState?.validate() ?? false;

                if (!isValid) return;
                familyAccount(context);
              },
              color: AppColors.btn_primery,
              width: double.infinity,
            ),
        ],
      ),
    );
  }
}
