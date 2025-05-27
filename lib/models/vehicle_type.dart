import 'package:car_rental/models/vehicle_model.dart';

class VehicleTypeModel {
  final String id;
  final String title;
  final int wheels;
  final String type;
  final List<VehicleModel> vehicles;

  VehicleTypeModel({
    required this.id,
    required this.title,
    required this.wheels,
    required this.type,
    required this.vehicles,
  });

  factory VehicleTypeModel.fromJson(Map<String, dynamic> json) {
    return VehicleTypeModel(
      id: json['id'],
      title: json['title'],
      wheels: json['wheels'],
      type: json['type'],
      vehicles:
          (json['vehicles'] as List)
              .map((e) => VehicleModel.fromJson(e))
              .toList(),
    );
  }
}
