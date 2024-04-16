import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mine/app/routes/app_pages.dart';
import 'package:mine/services/authentication_service.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_size_config.dart';
import '../controllers/user_home_controller.dart';

class UserHomeView extends GetWidget<UserHomeController> {
  const UserHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diary'),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            onSelected: (val) {
              AuthService().signOut();
            },
            itemBuilder: (context) => [
              // popupmenu item 1
              const PopupMenuItem(
                value: 1,
                // row has two child icon and text.
                child: Text("Log out     "),
              ),
              // popupmenu item 2
            ],
            offset: const Offset(0, 50),
            color: Colors.white,
            elevation: 2,
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }


            return ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var userData = snapshot.data!.docs[index].data();
                  return InkWell(
                    onTap: () {
                      Get.toNamed(Routes.CALLING);
                    },
                    child:!controller.showIds.contains((userData as Map<String, dynamic>)["id"] )  ? const SizedBox(): Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          border: Border.all()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor:
                                AppColor.primaryColor.withOpacity(0.5),
                            child: Text(
                                (userData)["name"][0]),
                          ),
                          Space.width(20),
                          Expanded(
                            child: Text((userData)["name"] ?? ""),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
