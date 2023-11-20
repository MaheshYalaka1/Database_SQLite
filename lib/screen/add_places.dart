import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insert_database/provider/user_places.dart';
import 'package:insert_database/widget/image_input.dart';
import 'package:insert_database/widget/input_location.dart';
//import 'package:sqflite/sqlite_api.dart';

class AddPlaceScreenState extends ConsumerStatefulWidget {
  const AddPlaceScreenState({super.key});
  @override
  ConsumerState<AddPlaceScreenState> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreenState> {
  File? _setectedImage;
  final _titleController = TextEditingController();

  void _savePlaces() {
    final enterTitel = _titleController.text;

    if (enterTitel.isEmpty || _setectedImage == null) {
      return;
    }
    ref.read(userplaceprovider.notifier).addplace(enterTitel, _setectedImage!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add a new place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Titel'),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            ImageInput(
              onPicked: (image) {
                _setectedImage = image;
              },
            ),
            const SizedBox(
              height: 17,
            ),
            const LocationInput(),
            const SizedBox(
              height: 17,
            ),
            ElevatedButton.icon(
              onPressed: _savePlaces,
              icon: const Icon(Icons.add),
              label: const Text("add place"),
            ),
          ],
        ),
      ),
    );
  }
}
