import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class Imageget extends StatefulWidget {
  Imageget({Key? key}) : super(key: key);

  @override
  _ImagegetState createState() => _ImagegetState();
}

class _ImagegetState extends State<Imageget> {
  File? _image;
  final picker = ImagePicker();

  Future _getImage() async {
    //カメラロールから読み取る
    //final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('画像が選択できませんでした。');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('画像選択'),
      ),
      body: Center(
        child: _image == null ? Text('No image selected.') : Image.file(_image!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        child: Icon(Icons.image),
      ),
    );
  }
}