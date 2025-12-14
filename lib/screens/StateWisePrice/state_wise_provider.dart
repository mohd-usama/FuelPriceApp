import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuel_price_app/Model/fuel_price_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StateWiseProvider extends ChangeNotifier {
  List<FuelPriceModel> originList = [];
  List<FuelPriceModel> destinationList = [];

  FuelPriceModel destinationValue = FuelPriceModel();
  FuelPriceModel originValue = FuelPriceModel();
  FuelPriceModel? selectedOriginFuelData;
  FuelPriceModel? selectDestinationFuelData;
  String? selectedOrigin;
  String? selectedDestination;
  bool? enableMap = false;
  GoogleMapController? mapController;

  Future<void> loadFuelData() async {
    final data = await rootBundle.loadString('assest/response.json');
    final Map<String, dynamic> jsonMap = json.decode(data);
    List jsonList = jsonMap['data'];
    originList = jsonList.map((e) => FuelPriceModel.fromJson(e)).toList();
    destinationList = jsonList.map((e) => FuelPriceModel.fromJson(e)).toList();
    notifyListeners();
  }

  void setOriginValue(String? v) {
    selectedOrigin = v;
    selectedOriginFuelData = originList.firstWhere((e) => e.state == v);
    notifyListeners();
  }

  void setDestinationValue(String? v) {
    selectedDestination = v;
    selectDestinationFuelData = destinationList.firstWhere((e) => e.state == v);
    notifyListeners();
  }

  void showMapOnScreen() {
    enableMap = true;
    notifyListeners();
  }

  void clear() {
    selectedOrigin = null;
    selectedDestination = null;
    selectedOriginFuelData = null;
    selectDestinationFuelData = null;
    enableMap = false;
    notifyListeners();
  }


  bool validation(BuildContext context){
    if(selectedOrigin == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select Origin State")));
      return false;
    }
    else if(selectedDestination==null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select Destination State")));
      return false;
    }
    return true;
  }
}
