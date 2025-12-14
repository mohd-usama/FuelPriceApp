import 'package:flutter/material.dart';
import 'package:fuel_price_app/Utils/custom_widgets.dart';
import 'package:fuel_price_app/screens/price_list/price_list_provider.dart';
import 'package:provider/provider.dart';

import '../../Utils/map_screen.dart';

class PriceListScreen extends StatefulWidget {
  const PriceListScreen({super.key});

  @override
  State<PriceListScreen> createState() => _PriceListScreenState();
}

class _PriceListScreenState extends State<PriceListScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PriceListProvider>().loadFuelData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Fuel Price List "),
        ),
        body: Consumer<PriceListProvider>(builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextFormField(
                  controller: provider.searchCtr,
                  onChanged: (v){
                    if(v.isNotEmpty){
                      provider.searchState(v);
                    }
                    else
                      {
                        provider.loadFuelData();
                      }

                  },
                  decoration: InputDecoration(
                      hintText: "Search State",
                      label: const Text("Search State"),
                      labelStyle: const TextStyle(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(7), borderSide: const BorderSide(color: Colors.white)),
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(7), borderSide: const BorderSide(color: Colors.white))),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: provider.fuelPriceList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data = provider.fuelPriceList[index];
                          return GestureDetector(
                            onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreen(stateData: data)));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 4), // shadow position
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Row(
                                        children: [
                                          const Icon(Icons.pin_drop_rounded, size: 40, color: Colors.blue),
                                          Text(data.state!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
                                        ],
                                      )),
                                      const Icon(Icons.arrow_forward_ios_sharp),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(

                                    children: [
                                      Expanded(
                                          child: CustomWidgets.customContainer(
                                              "Petrol", data.fuelPrices!.petrolPrice!.toString(), Colors.orange.shade100,borderColor: Colors.orange)),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: CustomWidgets.customContainer(
                                              "Diesel", data.fuelPrices!.dieselPrice!.toString(), Colors.green.shade100,borderColor: Colors.green))
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(

                                    children: [
                                      Expanded(
                                          child: CustomWidgets.customContainer(
                                              "CNG", data.fuelPrices!.cngPrice!.toString(), Colors.yellow.shade100,borderColor: Colors.yellow)),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: CustomWidgets.customContainer(
                                              "EV", data.fuelPrices!.electricityPrice!.toString(), Colors.blue.shade100,borderColor: Colors.blue))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }))
              ],
            ),
          );
        }));
  }
}
