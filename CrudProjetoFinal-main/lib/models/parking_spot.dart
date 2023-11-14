class ParkingSpot {
  final String? id;
  final String? licensePlate;
  final String? state;
  final String? model;
  final String? color;
  final DateTime? registrationDate;
  final String? parkingSpotNumber;
  final String? brandCar;
  final String? responsibleName;
  final String? apartment;
  final String? block;

  ParkingSpot({
    this.id,
    this.licensePlate,
    this.state,
    this.model,
    this.color,
    this.registrationDate,
    this.parkingSpotNumber,
    this.brandCar,
    this.responsibleName,
    this.apartment,
    this.block,
  });

  factory ParkingSpot.fromJson(Map<String, dynamic> json) {
    return ParkingSpot(
      id: json['id'],
      licensePlate: json['licensePlateCar'],
      model: json['modelCar'],
      color: json['colorCar'],
      registrationDate: json['registrationDate'] != null
          ? DateTime.parse(json['registrationDate'])
          : null,
      parkingSpotNumber: json['parkingSpotNumber'],
      brandCar: json['brandCar'],
      responsibleName: json['responsibleName'],
      apartment: json['apartment'],
      block: json['block'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id ?? "";
    data['parkingSpotNumber'] = parkingSpotNumber ?? "";
    data['licensePlateCar'] = licensePlate ?? "";
    data['brandCar'] = brandCar ?? "";
    data['modelCar'] = model ?? "";
    data['colorCar'] = color ?? "";
    data['registrationDate'] = registrationDate?.toIso8601String() ?? "";
    data['responsibleName'] = responsibleName ?? "";
    data['apartment'] = apartment ?? "";
    data['block'] = block ?? "";
    return data;
  }
}
