class LocalBookingModel {
  final String? firstName;
  final String? lastName;
  final int? wheels;
  final String? vehicleType;
  final String? vehicleModel;
  final DateTime? startDate;
  final DateTime? endDate;

  LocalBookingModel({
    this.firstName,
    this.lastName,
    this.wheels,
    this.vehicleType,
    this.vehicleModel,
    this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'wheels': wheels,
      'vehicleType': vehicleType,
      'vehicleModel': vehicleModel,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
    };
  }

  factory LocalBookingModel.fromMap(Map<String, dynamic> map) {
    return LocalBookingModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      wheels: map['wheels'],
      vehicleType: map['vehicleType'],
      vehicleModel: map['vehicleModel'],
      startDate: DateTime.tryParse(map['startDate'] ?? ''),
      endDate: DateTime.tryParse(map['endDate'] ?? ''),
    );
  }
}
