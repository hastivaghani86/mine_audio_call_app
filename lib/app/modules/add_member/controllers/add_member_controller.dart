import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddMemberController extends GetxController {
  Rx<TextEditingController> memberIdController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> numberController = TextEditingController().obs;

}
