import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insert_database/modal/Newplace.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

Future<Database> _getDatabase() async {
  final dbPath = await getDatabasesPath();
  final db = await openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREARE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT,lat REAL,lng REAL,address TEXT)');
    },
    version: 1,
  );
  return db;
}

class UesrPlaceNotifier extends StateNotifier<List<Place>> {
  UesrPlaceNotifier() : super(const []);
  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: placeLocation(
                latitude: row['lat'] as double,
                address: row['address'] as String,
                longitude: row['lng'] as double),
          ),
        )
        .toList();
    state = places;
  }

  void addplace(String title, File image, placeLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');
    final newplace =
        Place(title: title, image: copiedImage, location: location);
    final db = await _getDatabase();

    db.insert('user_places', {
      'id': newplace.id,
      'title': newplace.title,
      'image': newplace.image.path,
      'lat': newplace.location.latitude,
      'lng': newplace.location.longitude,
      'address': newplace.location.address,
    });
    state = [newplace, ...state];
  }
}

final userplaceprovider = StateNotifierProvider<UesrPlaceNotifier, List<Place>>(
    (ref) => UesrPlaceNotifier());
