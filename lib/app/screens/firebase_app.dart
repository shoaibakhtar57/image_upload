import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hit_mubashar/app/controller/app_controller.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageApp extends StatelessWidget {
  FirebaseStorageApp({Key? key}) : super(key: key);

  final imagePicker = ImagePicker();

  final appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => appController.isLoading.value == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: GestureDetector(
                onTap: () async {
                  print('Tapped');

                  //FOR SINGLE IMAGE
                  // final pickedFile =
                  //     await imagePicker.pickImage(source: ImageSource.gallery);
                  // if (pickedFile != null) {
                  //   final imageBytes = await pickedFile.readAsBytes();
                  //   final imageFile = File(imageBytes, pickedFile.path);

                  //   //CALLING NETWORK CLASS THROUGH NOTIFIER
                  //   appController.uploadImageToStorage(imageFile);
                  // }

                  //FOR LIST OF IMAGES

                  List<XFile>? images = await imagePicker.pickMultiImage();

                  if (images!.isNotEmpty && images.length != 0) {
                    for (final image in images) {
                      final imageFile = File(image.path);
                      appController.imageFiles.add(imageFile);
                    }

                    appController.uploadListOfImages();
                  }
                },
                child: Container(
                    height: 50.0,
                    width: 80.0,
                    color: Colors.red,
                    child: Text('Get File')),
              ),
            ),
    ));
  }
}
