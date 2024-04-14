import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mine/utils/app_text_field.dart';

import '../../../../utils/app_size_config.dart';
import '../controllers/add_member_controller.dart';

class AddMemberView extends GetView<AddMemberController> {
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
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Space.height(20),
            const Text(
              "Member Id",
              style: TextStyle(fontSize: 18),
            ),
            AppTextField(),
            Space.height(20),
            const Text(
              "Name",
              style: TextStyle(fontSize: 18),
            ),
            AppTextField(),
            Space.height(20), const Text(
              "Number",
              style: TextStyle(fontSize: 18),
            ),
            AppTextField(),
            Space.height(20),
          ],
        ),
      ),
    );
  }
}
