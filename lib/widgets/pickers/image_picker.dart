import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFunction;
  UserImagePicker(this.imagePickFunction);

  @override
  State<UserImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<UserImagePicker> {
  File? _selectedImg;
  void _selectImage() async{
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera,imageQuality: 50,maxWidth: 150);
    final pickedImagePath = File(pickedImage?.path ?? '');
    setState(() {
      _selectedImg = pickedImagePath;
    });

    widget.imagePickFunction(pickedImagePath);

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: _selectedImg != null ? FileImage(_selectedImg!) : null,
        ),
        TextButton.icon(
            onPressed: _selectImage,
            icon: Icon(Icons.image),
            label: Text(
              'Add Image',
              style: TextStyle(color: Theme.of(context).primaryColor),
            )),
      ],
    );
  }
}
