class BookingDateModel {
  final DateTime startDate;
  final DateTime endDate;

  BookingDateModel({required this.startDate, required this.endDate});

  factory BookingDateModel.fromJson(Map<String, dynamic> json) {
    return BookingDateModel(
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }
}
