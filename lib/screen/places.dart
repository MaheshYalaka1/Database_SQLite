import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insert_database/provider/user_places.dart';
import 'package:insert_database/screen/add_places.dart';
import 'package:insert_database/widget/places_list.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});
  @override
  ConsumerState<PlacesScreen> createState() {
    return _placesScreenState();
  }
}

class _placesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _placesFuture;
  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userplaceprovider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userplaces = ref.watch(userplaceprovider);

    return Scaffold(
      appBar: AppBar(
        title: Text('yuor place'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddPlaceScreenState(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _placesFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : placesList(places: userplaces),
        ),
      ),
    );
  }
}
