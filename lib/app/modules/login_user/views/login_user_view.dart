import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mine/utils/app_text_field.dart';

import '../controllers/login_user_controller.dart';

class LoginUserView extends GetView<LoginUserController> {
  const LoginUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          AppTextField(

          )
        ],
      ),
    );
  }
}
