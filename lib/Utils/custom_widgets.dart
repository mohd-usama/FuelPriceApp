import 'package:flutter/material.dart';
import 'package:fuel_price_app/Model/fuel_price_model.dart';

class CustomWidgets {
  static Widget listTileWidget({String? title, String? subtitle, void Function()? onTap, Widget? leading}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.blue,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 4), // shadow position
          ),
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: leading,
        title: Text(
          title ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(subtitle ?? ""),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  static Widget customContainer(String title, String value, Color? color, {double? height, Color? borderColor}) {
    return Container(
        height: height ?? 25,
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: borderColor ?? Colors.black), borderRadius: BorderRadius.circular(5), color: color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${title} : "),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ));
  }

  static Widget customContainer2(String title, String value, Color? color, {double? height, Color? borderColor, Widget? iconData}) {
    return Container(
        height: height ?? 25,
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: borderColor ?? Colors.black),
            borderRadius: BorderRadius.circular(5),
            color: color!.withOpacity(0.3)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                iconData!,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " $title",
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Text(
                      value,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  static Widget customDropDown({
    required List<FuelPriceModel> list,
    required String? selectedState,
    required void Function(String?) onChanged,
    Widget? hint,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 10,right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all()

      ),
      child: DropdownButton<String>(

        value: selectedState,
        hint: hint ?? const Text("Select State"),
        isExpanded: true,
        items: list.map((FuelPriceModel item) {
          return DropdownMenuItem<String>(
            value: item.state,
            child: Text(item.state!),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );


  }


  Widget priceBottomSheetContent(FuelPriceModel stateData,{bool? showDragButton=true}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            if(showDragButton!)
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            // State name
            Row(
              children: [
                Text(
                  stateData.state!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "  (Perice Per Liter)",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Petrol & Diesel
            Row(
              children: [
                Expanded(
                  child: CustomWidgets.customContainer2(
                      height: 70,
                      "Petrol",
                      stateData.fuelPrices!.petrolPrice!.toString(),
                      Colors.orange.shade100,
                      borderColor: Colors.orange,
                      iconData: const Icon(Icons.ev_station, color: Colors.orange, size: 45)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomWidgets.customContainer2(
                      height: 70,
                      "Diesel",
                      stateData.fuelPrices!.dieselPrice!.toString(),
                      Colors.green.shade100,
                      borderColor: Colors.green,
                      iconData: const Icon(Icons.ev_station, color: Colors.green, size: 45)),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // CNG & EV
            Row(
              children: [
                Expanded(
                  child: CustomWidgets.customContainer2(
                      height: 70,
                      "CNG",
                      stateData.fuelPrices!.cngPrice!.toString(),
                      Colors.yellow.shade100,
                      borderColor: Colors.yellow,
                      iconData: const Icon(Icons.gas_meter, color: Colors.yellow, size: 45)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomWidgets.customContainer2(
                      height: 70,
                      "EV",
                      stateData.fuelPrices!.electricityPrice!.toString(),
                      Colors.blue.shade100,
                      borderColor: Colors.blue,
                      iconData: const Icon(Icons.electric_bolt, color: Colors.blue, size: 45)),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

}
