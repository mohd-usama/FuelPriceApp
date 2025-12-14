import 'package:flutter/material.dart';
import 'package:fuel_price_app/Model/fuel_price_model.dart';
import 'package:fuel_price_app/Utils/custom_widgets.dart';
import 'package:fuel_price_app/screens/StateWisePrice/state_wise_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class StateWiseScreen extends StatefulWidget {
  const StateWiseScreen({super.key});

  @override
  State<StateWiseScreen> createState() => _StateWiseScreenState();
}

class _StateWiseScreenState extends State<StateWiseScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StateWiseProvider>().loadFuelData();
    });
  }

  @override
  void dispose() {
    context.read<StateWiseProvider>().clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("State Wise Price"),
      ),
      body: Consumer<StateWiseProvider>(builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  
                ),
                child: Column(
                  children: [
                    const Text("Select State",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                    const SizedBox(height: 10),

                    CustomWidgets.customDropDown(
                        selectedState: provider.selectedOrigin,
                        list: provider.originList,
                        onChanged: (String? v) {
                          provider.setOriginValue(v);
                        },
                        hint: const Text("Origin")),
                    const SizedBox(height: 10),
                    CustomWidgets.customDropDown(
                        selectedState: provider.selectedDestination,
                        list: provider.destinationList,
                        onChanged: (String? v) {
                          provider.setDestinationValue(v);
                        },
                        hint: const Text("Destination")),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if(provider.validation(context)){
                              provider.showMapOnScreen();
                            }

                          },
                          child: const Text(
                            "Get Price",
                            style: TextStyle(color: Colors.teal),
                          )),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            provider.clear();
                          },
                          child: const Text(
                            "Reset",
                            style: TextStyle(color: Colors.red),
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (provider.enableMap == true)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 300,
                    child: GoogleMap(
                      onMapCreated: (controller) {
                        provider.mapController = controller;
                        _fitMarkers(provider);
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(provider.selectedOriginFuelData!.lat!, provider.selectedOriginFuelData!.long!),
                        zoom: 10,
                      ),
                      markers: {
                        Marker(
                            markerId: MarkerId(provider.selectedOriginFuelData!.state!),
                            position: LatLng(provider.selectedOriginFuelData!.lat!, provider.selectedOriginFuelData!.long!),
                            infoWindow: InfoWindow(title: provider.selectedOriginFuelData!.state)),
                        Marker(
                          markerId: MarkerId(provider.selectDestinationFuelData!.state!),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueBlue,
                          ),
                          position: LatLng(
                            provider.selectDestinationFuelData!.lat!,
                            provider.selectDestinationFuelData!.long!,
                          ),
                          infoWindow: InfoWindow(title: provider.selectDestinationFuelData!.state),
                        ),
                      },
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              if (provider.selectedOriginFuelData != null && provider.enableMap == true)
                Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomWidgets().priceBottomSheetContent(provider.selectedOriginFuelData!, showDragButton: false)),
              const SizedBox(height: 20),
              if (provider.selectDestinationFuelData != null && provider.enableMap == true)
                Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomWidgets().priceBottomSheetContent(provider.selectDestinationFuelData!, showDragButton: false)),
            ],
          ),
        );
      }),
    );
  }

  void _fitMarkers(StateWiseProvider provider) {
    if (provider.mapController == null) return;

    final origin = LatLng(
      provider.selectedOriginFuelData!.lat!,
      provider.selectedOriginFuelData!.long!,
    );

    final destination = LatLng(
      provider.selectDestinationFuelData!.lat!,
      provider.selectDestinationFuelData!.long!,
    );

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        origin.latitude < destination.latitude ? origin.latitude : destination.latitude,
        origin.longitude < destination.longitude ? origin.longitude : destination.longitude,
      ),
      northeast: LatLng(
        origin.latitude > destination.latitude ? origin.latitude : destination.latitude,
        origin.longitude > destination.longitude ? origin.longitude : destination.longitude,
      ),
    );

    provider.mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 80),
    );
  }
}
