import 'package:flutter/material.dart';
import 'package:fuel_price_app/screens/StateWisePrice/state_wise_provider.dart';
import 'package:fuel_price_app/screens/price_list/price_list_provider.dart';
import 'package:fuel_price_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PriceListProvider()),
        ChangeNotifierProvider(create: (_) => StateWiseProvider()),
      ],
      child: MaterialApp(
        title: 'Fuel Price',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(centerTitle: true,color:Colors.blueAccent.shade100,titleTextStyle: TextStyle(color: Colors.white,fontSize: 25),iconTheme: IconThemeData(color: Colors.white) ),
          scaffoldBackgroundColor: Colors.blueAccent.shade100,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
