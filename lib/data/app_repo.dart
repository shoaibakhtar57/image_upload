import 'dart:developer';
import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:hit_mubashar/app/screens/firebase_app.dart';

class AppRepo {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadImage(image) async {
    //TODO: Upload Image

    try {
      String downloadUrl;

      final storageRef = firebaseStorage.ref().child('images/');

      UploadTask uploadTask = storageRef.putFile(image);

      uploadTask.then((snapshot) async {
        log('GETTING URL::: ${snapshot.ref.getDownloadURL()}');
        downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      });
    } catch (e) {
      print('There was an error while uploading Image $e');
      return null;
    }
  }

  Future<void> uploadUserData(userData) async {}
}
