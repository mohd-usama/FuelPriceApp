import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Model/fuel_price_model.dart';
import 'custom_widgets.dart';

class MapScreen extends StatelessWidget {
  final FuelPriceModel stateData;

  const MapScreen({super.key, required this.stateData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(stateData.state!)),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(stateData.lat!, stateData.long!),
              zoom: 10,
            ),
            markers: {
              Marker(
                  markerId: MarkerId(stateData.state!),
                  position: LatLng(stateData.lat!, stateData.long!),
                  infoWindow: InfoWindow(title: stateData.state))
            },
          ),
          Align(alignment: Alignment.bottomCenter, child: CustomWidgets().priceBottomSheetContent(stateData))
        ],
      ),
    );
  }


}
