import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine/app/routes/app_pages.dart';
import 'package:mine/main.dart';
import 'package:mine/services/authentication_service.dart';
import 'package:mine/utils/app_key_storage.dart';

import '../../../../utils/app_color.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  final RxBool isVisible = false.obs;
  final RxBool isVisible1 = false.obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  RxBool isLoading = false.obs;

  login({required BuildContext context}) async {
    if (formKeyLogin.currentState!.validate()) {
      isLoading.value = true;
      String? result = await AuthService()
          .login(
              email: emailController.value.text.toString().trim(),
              password: passwordController.value.text.trim().toString())
          .then((value) {
        if (value == "Success") {
          isLoading.value = false;
          box.write(StorageKeys.role, "Admin");
          box.write(StorageKeys.isLogin, true);
          Get.toNamed(Routes.HOME);
        } else {
          isLoading.value = false;
          Get.snackbar("ERROR!", value ?? "Something went wrong",
              colorText: AppColor.white, backgroundColor: Colors.redAccent);
        }
      });
    }
  }

  signUp({required BuildContext context}) async {
    if (formKeyLogin.currentState!.validate()) {
      isLoading.value = true;
      String? result = await AuthService()
          .registration(
              email: emailController.value.text.toString().trim(),
              password: passwordController.value.text.trim().toString())
          .then((value) {
        if (value == "Success") {
          isLoading.value = false;
          box.write(StorageKeys.role, "Admin");
          box.write(StorageKeys.isLogin, true);
          Get.toNamed(Routes.HOME);
        } else {
          isLoading.value = false;
          Get.snackbar("ERROR!", value ?? "Something went wrong",
              colorText: AppColor.white, backgroundColor: Colors.redAccent);
        }
      });
    }
  }
}
