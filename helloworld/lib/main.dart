import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helloworld/test_page2.dart';
import 'package:helloworld/test_page3.dart';
import 'package:image_picker/image_picker.dart';
import 'test_page1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  XFile? _image;
  final imagePicker = ImagePicker();

  // カメラから写真を取得するメソッド
  Future getImageFromCamera() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = XFile(pickedFile.path);
      }
    });
  }

  // ギャラリーから写真を取得するメソッド
  Future getImageFromGallery() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = XFile(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: _image == null
              ? Text(
                  '写真を選択してください',
                  style: Theme.of(context).textTheme.headline4,
                )
              : Image.file(File(_image!.path))),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // カメラから取得するボタン
          FloatingActionButton(
            onPressed: getImageFromCamera,
            child: const Icon(Icons.photo_camera),
          ),
          FloatingActionButton(
            onPressed: getImageFromGallery,
            child: const Icon(Icons.photo_album),
          )
        ],
      ),
    );
  }
}
