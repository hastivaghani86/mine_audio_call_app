import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mine/main.dart';

import '../../../../utils/app_key_storage.dart';
import '../../../routes/app_pages.dart';

class WelcomeController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 10), () {
      print("READ ${box.read(StorageKeys.role)}");
      if (box.read(StorageKeys.role) != null) {
        if (box.read(StorageKeys.role) == "Admin" && box.read(StorageKeys.isLogin)) {
          Get.offAllNamed(Routes.HOME);
        } else if (box.read(StorageKeys.role) == "User") {
          Get.offAllNamed(Routes.USER_HOME);
        }
      }
    });
    super.onInit();
  }
}
