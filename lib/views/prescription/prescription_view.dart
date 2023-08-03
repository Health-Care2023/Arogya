import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hello/db/photo_database.dart';
import 'package:hello/views/prescription/photo.dart';
import 'package:hello/views/profile_view.dart';
import 'package:image_picker/image_picker.dart';

class PrescriptionView extends StatefulWidget {
  const PrescriptionView({super.key});

  @override
  State<PrescriptionView> createState() => _PrescriptionViewState();
}

class _PrescriptionViewState extends State<PrescriptionView> {
  late File imageFile;
  Image? image;

  late final DbHelper db;
  late List<Photo> photos;
  final ImagePicker _picker = ImagePicker();
  late Uint8List img;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DbHelper();
    photos = [];
  }

  refresgImages() {
    db.getPhotos().then(
      (value) {
        photos.clear();
        photos.addAll(value);
      },
    );
  }

  pickImage() async {
    final picture = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(picture!.path);
      img = imageFile.readAsBytesSync();
    });
    Photo photo = Photo(0, img);
    db.save(photo);
    refresgImages();
  }

  gridView() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: photos.map((photo) {
          var imgstr = Utility.base64String(photo.name!);
          return Utility.imageFromBase64String(imgstr);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Prescription"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                pickImage();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Flexible(child: gridView())],
        ),
      ),
    );
  }
}
