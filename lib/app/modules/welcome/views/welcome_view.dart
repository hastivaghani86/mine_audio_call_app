import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mine/utils/app_button.dart';
import 'package:mine/utils/app_size_config.dart';

import '../../../routes/app_pages.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetWidget<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('WelcomeView'),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const Center(
            //   child: Text(
            //     'WelcomeView ',
            //     style: TextStyle(fontSize: 20),
            //   ),
            // ),
            // Space.height(100),
            AppButton(
              btnText: "Continue as Admin",
              onTap: () {
                Get.toNamed(Routes.LOGIN);
              },
            ),
            Space.height(30),
            AppButton(
              btnText: "Continue as User",
              onTap: () {
                Get.toNamed(Routes.LOGIN_USER);
              },
            )
          ],
        ),
      ),
    );
  }
}
