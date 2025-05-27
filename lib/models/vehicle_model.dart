class VehicleModel {
  final String id;
  final String name;
  final String? imageUrl;

  VehicleModel({required this.id, required this.name, this.imageUrl});

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image']?['publicURL'],
    );
  }
}
