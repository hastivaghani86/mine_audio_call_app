import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mine/utils/app_button.dart';
import 'package:mine/utils/app_text_field.dart';

import '../../../../utils/app_size_config.dart';
import '../controllers/add_member_controller.dart';

class AddMemberView extends GetWidget<AddMemberController> {
  const AddMemberView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Add New Member'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Colors.orange,
              height: 4.0,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Space.height(20),
            const Text(
              "Member Id",
              style: TextStyle(fontSize: 18),
            ),
            AppTextField(
              controller: controller.memberIdController.value,
              hintText: "Member Id",
            ),
            Space.height(20),
            const Text(
              "Name",
              style: TextStyle(fontSize: 18),
            ),
            AppTextField(
              controller: controller.nameController.value,
              hintText: "Name",
            ),
            Space.height(20),
            const Text(
              "Number",
              style: TextStyle(fontSize: 18),
            ),
            AppTextField(
              controller: controller.numberController.value,
              hintText: "Number",
            ),
            Space.height(50),
            AppButton(
                btnText: "Add Member",
                onTap: () {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(controller.memberIdController.value.text
                          .trim()
                          .toString())
                      .set({
                    "id": controller.memberIdController.value.text
                        .trim()
                        .toString(),
                    "name": controller.nameController.value.text.trim(),
                    "number": controller.numberController.value.text.toString(),
                    "showId": []
                  });
                }),
          ],
        ),
      ),
    );
  }
}
