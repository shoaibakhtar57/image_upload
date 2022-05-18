import 'dart:io';

import 'package:get/get.dart';
import 'package:hit_mubashar/data/app_repo.dart';

class AppController extends GetxController {
  final appRepo = AppRepo();

  RxBool isLoading = false.obs;

  List<File> imageFiles = List.empty(growable: true);

  List<String> downloadUrls = List.empty(growable: true);

  Future<void> uploadImageToStorage(image) async {
    isLoading.value = true;
    final downloadUrl = await appRepo.uploadImage(image);

    //TODO: SEND THIS URL TO FIREBASE

    final userData = {
      'name': 'Shoaib',
      'uid': 'slkdjflsajkl',
      'imageUrl': downloadUrl
    };

    appRepo.uploadUserData(userData);

    isLoading.value = false;
  }

  //LIST OF IMAGES
  Future<void> uploadListOfImages() async {
    isLoading.value = true;

    imageFiles.map((file) => appRepo.uploadImage(file).then((value) {
          if (value != null) {
            downloadUrls.add(value);
          }
        }));

        
    final userData = {
      'name': 'Shoaib',
      'uid': 'slkdjflsajkl',
      'imageUrl': downloadUrls
    };


    isLoading.value = false;
  }
}
