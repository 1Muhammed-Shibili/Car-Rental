class LocalBookingModel {
  final String? firstName;
  final String? lastName;
  final int? wheels;
  final String? vehicleType;
  final String? vehicleModel;
  final String? vehicleTypeName;
  final String? vehicleModelName;
  final String? vehicleImageUrl;
  final DateTime? startDate;
  final DateTime? endDate;

  LocalBookingModel({
    this.firstName,
    this.lastName,
    this.wheels,
    this.vehicleType,
    this.vehicleModel,
    this.vehicleTypeName,
    this.vehicleModelName,
    this.vehicleImageUrl,
    this.startDate,
    this.endDate,
  });
  LocalBookingModel copyWith({
    String? firstName,
    String? lastName,
    int? wheels,
    String? vehicleType,
    String? vehicleModel,
    String? vehicleTypeName,
    String? vehicleModelName,
    String? vehicleImageUrl,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return LocalBookingModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      wheels: wheels ?? this.wheels,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleModel: vehicleModel ?? this.vehicleModel,
      vehicleTypeName: vehicleTypeName ?? this.vehicleTypeName,
      vehicleModelName: vehicleModelName ?? this.vehicleModelName,
      vehicleImageUrl: vehicleImageUrl ?? this.vehicleImageUrl,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  LocalBookingModel copyWithFrom(LocalBookingModel other) {
    return LocalBookingModel(
      firstName: other.firstName ?? firstName,
      lastName: other.lastName ?? lastName,
      wheels: other.wheels ?? wheels,
      vehicleType: other.vehicleType ?? vehicleType,
      vehicleModel: other.vehicleModel ?? vehicleModel,
      vehicleTypeName: other.vehicleTypeName ?? vehicleTypeName,
      vehicleModelName: other.vehicleModelName ?? vehicleModelName,
      vehicleImageUrl: other.vehicleImageUrl ?? vehicleImageUrl,
      startDate: other.startDate ?? startDate,
      endDate: other.endDate ?? endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'wheels': wheels,
      'vehicleType': vehicleType,
      'vehicleModel': vehicleModel,
      'vehicleTypeName': vehicleTypeName,
      'vehicleModelName': vehicleModelName,
      'vehicleImageUrl': vehicleImageUrl,
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
      vehicleTypeName: map['vehicleTypeName'],
      vehicleModel: map['vehicleModel'],
      vehicleModelName: map['vehicleModelName'],
      vehicleImageUrl: map['vehicleImageUrl'],
      startDate: DateTime.tryParse(map['startDate'] ?? ''),
      endDate: DateTime.tryParse(map['endDate'] ?? ''),
    );
  }
}
