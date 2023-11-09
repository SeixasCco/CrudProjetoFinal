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

  // Update toJson method if needed
  Map<String, dynamic> toJson() => {
    'id': id,
    'licensePlate': licensePlate,
    'parkingSpotNumber': parkingSpotNumber,
    'brandCar': brandCar,
    'modelCar': model,
    'colorCar': color,
    'registrationDate': registrationDate?.toIso8601String(),
    'responsibleName': responsibleName,
    'apartment': apartment,
    'block': block,
  };
}
