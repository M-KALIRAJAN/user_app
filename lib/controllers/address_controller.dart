import 'package:flutter/material.dart';

class AddressController {
  TextEditingController building = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController aptNo = TextEditingController();
  TextEditingController floor = TextEditingController();

  // NEW fields
  String? road; // selected road
  String? block; // selected block
  List<Map<String, dynamic>> blocksForSelectedRoad = []; // blocks for selected road

  Map<String, dynamic> getAddressData() {
    return {
      "building": building.text,
      "city": city.text,
      "aptNo": aptNo.text,
      "floor": floor.text,
      "road": road,
      "block": block,
    };
  }

  String? validateBuilding(String? val) => val?.isEmpty ?? true ? "Required" : null;
  String? validateAptNo(String? val) => val?.isEmpty ?? true ? "Required" : null;
  String? validateFloor(String? val) => val?.isEmpty ?? true ? "Required" : null;
}
