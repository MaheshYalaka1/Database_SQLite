import 'package:flutter/material.dart';
import 'package:insert_database/modal/Newplace.dart';

class placeDetailsScreen extends StatelessWidget {
  const placeDetailsScreen({super.key, required this.place});
  final Place place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
        ],
      ),
    );
  }
}
