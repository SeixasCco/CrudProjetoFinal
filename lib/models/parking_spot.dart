class ParkingSpot {
  final String? id;
  final String? licensePlate;
  final String? state;
  final String? model;
  final String? color;
  final DateTime? registrationDate;

  ParkingSpot({
    this.id,
    this.licensePlate,
    this.state,
    this.model,
    this.color,
    this.registrationDate,
  });

  factory ParkingSpot.fromJson(Map<String, dynamic> json) {
    return ParkingSpot(
      id: json['id'],
      licensePlate: json['licensePlate'],
      state: json['state'],
      model: json['model'],
      color: json['color'],
      registrationDate: DateTime.parse(json['registrationDate']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'licensePlate': licensePlate,
        'state': state,
        'model': model,
        'color': color,
        'registrationDate': registrationDate?.toIso8601String(),
      };
}
