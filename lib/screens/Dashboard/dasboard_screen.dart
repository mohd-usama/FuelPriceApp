import 'package:flutter/material.dart';
import 'package:fuel_price_app/Utils/custom_widgets.dart';
import 'package:fuel_price_app/screens/StateWisePrice/state_wise_provider.dart';
import 'package:fuel_price_app/screens/price_list/price_list_provider.dart';
import 'package:provider/provider.dart';

import '../StateWisePrice/state_wise_screen.dart';
import '../price_list/price_list_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fuel Price"),
      ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 7),
          const Icon(Icons.ev_station, size: 100, color: Colors.white),
          const Text(
            "Welcome Back To You",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          const SizedBox(height: 25),
          CustomWidgets.listTileWidget(
              title: "Check Price Using Map",
              subtitle: "Select State",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => StateWiseProvider(),
                      child: StateWiseScreen(),
                    ),
                  ),
                );
              },
              leading: const Icon(
                Icons.map,
                size: 40,
                color: Colors.blueAccent,
              )),
          const SizedBox(height: 10),
          CustomWidgets.listTileWidget(
              title: "Price List",
              subtitle: "All State Wise",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider(
                    create: (_) => PriceListProvider(),
                    child: PriceListScreen(),
                  ),
                ),);
              },
              leading: const Icon(
                Icons.price_change,
                size: 40,
                color: Colors.green,
              ))
        ],
      ),
    );
  }
}
