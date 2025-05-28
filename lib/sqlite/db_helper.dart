import 'dart:async';
import 'package:car_rental/models/local_booking_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    return _db ??= await initDb();
  }

  Future<Database> initDb() async {
    final path = join(await getDatabasesPath(), 'car_rental.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bookings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT,
        lastName TEXT,
        wheels INTEGER,
        vehicleType TEXT,
        vehicleTypeName TEXT,
        vehicleModel TEXT,
        vehicleModelName TEXT,
        vehicleImageUrl TEXT,
        startDate TEXT,
        endDate TEXT
      )
    ''');
  }

  Future<void> saveBooking(LocalBookingModel model) async {
    final dbClient = await db;
    final existing = await dbClient.query('bookings', limit: 1);

    if (existing.isNotEmpty) {
      await dbClient.update(
        'bookings',
        model.toMap(),
        where: 'id = ?',
        whereArgs: [existing.first['id']],
      );
    } else {
      await dbClient.insert('bookings', model.toMap());
    }
  }

  Future<LocalBookingModel?> getSavedBooking() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query(
      'bookings',
      limit: 1,
    );
    print('Fetched from DB: $maps');
    if (maps.isNotEmpty) {
      return LocalBookingModel.fromMap(maps.first);
    }

    return null;
  }

  Future<void> clearBooking() async {
    final dbClient = await db;
    await dbClient.delete('bookings');
  }
}
