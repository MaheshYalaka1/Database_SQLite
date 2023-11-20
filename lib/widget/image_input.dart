import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPicked});
  final void Function(File image) onPicked;
  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  void _tackpictur() async {
    final imagePicker = ImagePicker();
    final pickimage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickimage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(
        pickimage.path,
      );
    });
    widget.onPicked(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text('tack picturs'),
      onPressed: _tackpictur,
    );
    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _tackpictur,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
