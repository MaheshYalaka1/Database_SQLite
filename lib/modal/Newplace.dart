import 'dart:io';

import 'package:uuid/uuid.dart';

class placeLocation {
  const placeLocation(
      {required this.latitude, required this.address, required this.longitude});
  final double latitude;
  final double longitude;
  final String address;
}

const uuid = Uuid();

class Place {
  Place({
    required this.title,
    required this.image,
    required this.location,
    String? id,
  }) : id = id ?? uuid.v4();
  final String id;
  final String title;
  final File image;
  final placeLocation location;
}
