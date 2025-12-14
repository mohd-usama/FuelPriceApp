class FuelPriceModel {
  FuelPriceModel({
    this.state,
    this.lat,
    this.long,
    this.fuelPrices,
  });

  FuelPriceModel.fromJson(dynamic json) {
    state = json['state'];
    lat = json['lat'];
    long = json['long'];
    fuelPrices = json['fuel_prices'] != null ? FuelPrices.fromJson(json['fuel_prices']) : null;
  }
  String? state;
  double? lat;
  double? long;
  FuelPrices? fuelPrices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = state;
    map['lat'] = lat;
    map['long'] = long;
    if (fuelPrices != null) {
      map['fuel_prices'] = fuelPrices?.toJson();
    }
    return map;
  }
}

class FuelPrices {
  FuelPrices({
    this.petrolPrice,
    this.dieselPrice,
    this.cngPrice,
    this.electricityPrice,
  });

  FuelPrices.fromJson(dynamic json) {
    petrolPrice = json['petrol_price'];
    dieselPrice = json['diesel_price'];
    cngPrice = json['cng_price'];
    electricityPrice = json['electricity_price'];
  }

  double? petrolPrice;
  double? dieselPrice;
  double? cngPrice;
  double? electricityPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['petrol_price'] = petrolPrice;
    map['diesel_price'] = dieselPrice;
    map['cng_price'] = cngPrice;
    map['electricity_price'] = electricityPrice;
    return map;
  }
}
