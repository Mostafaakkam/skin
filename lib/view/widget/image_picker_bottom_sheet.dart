import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final Function(XFile?) onPickImage;

  const ImagePickerBottomSheet({super.key, required this.onPickImage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('الكاميرا'),
            onTap: () async {
              final pickedFile =
              await ImagePicker().pickImage(source: ImageSource.camera);
              onPickImage(pickedFile);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('المعرض'),
            onTap: () async {
              final pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
              onPickImage(pickedFile);
            },
          ),
        ],
      ),
    );
  }
}