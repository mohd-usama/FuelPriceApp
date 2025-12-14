import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../Model/fuel_price_model.dart';

class PriceListProvider extends ChangeNotifier {
  List<FuelPriceModel> fuelPriceList = [];
  List<FuelPriceModel> filteredList = [];

  TextEditingController searchCtr = TextEditingController();

  Future<void> loadFuelData() async {
    fuelPriceList.clear();
    final data = await rootBundle.loadString('assest/response.json');
    final Map<String, dynamic> jsonMap = json.decode(data);
    List jsonList = jsonMap['data'];
    fuelPriceList = jsonList.map((e) => FuelPriceModel.fromJson(e)).toList();
    notifyListeners();
  }

  void searchState(String v) {
    filteredList = fuelPriceList.where((data) => data.state!.toLowerCase().contains(v.toLowerCase())).toList();
    fuelPriceList = filteredList;
    notifyListeners();
  }
}
