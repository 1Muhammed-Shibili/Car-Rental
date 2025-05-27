class VehicleDetailModel {
  final String id;
  final String name;
  final String imageUrl;

  VehicleDetailModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory VehicleDetailModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return VehicleDetailModel(
      id: data['id'],
      name: data['name'],
      imageUrl: data['image']['publicURL'],
    );
  }
}
