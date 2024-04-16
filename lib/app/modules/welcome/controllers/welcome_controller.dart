import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mine/main.dart';

import '../../../../utils/app_key_storage.dart';
import '../../../routes/app_pages.dart';

class WelcomeController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 10), () {
      print("READ ${box.read(StorageKeys.isAdmin)}");
      if (box.read(StorageKeys.isAdmin) != null) {
        if (box.read(StorageKeys.isAdmin) == true && box.read(StorageKeys.uid) != null) {
          Get.offAllNamed(Routes.HOME);
        } else if (box.read(StorageKeys.isAdmin) == false && box.read(StorageKeys.uid) != null) {
          Get.offAllNamed(Routes.USER_HOME);
        }else{
          Get.snackbar("ERROR!", "Something went wrong");
        }
      }
    });
    super.onInit();
  }
}
