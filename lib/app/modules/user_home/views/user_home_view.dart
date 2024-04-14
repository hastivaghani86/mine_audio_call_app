import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mine/app/routes/app_pages.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_size_config.dart';
import '../controllers/user_home_controller.dart';

class UserHomeView extends GetView<UserHomeController> {
  const UserHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserHomeView'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream:FirebaseFirestore.instance.collection("users").snapshots() ,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot){
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
                    onTap: (){
                      Get.toNamed(Routes.CALLING);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          border: Border.all()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColor.primaryColor.withOpacity(0.5),
                            child: Text((userData as Map<String, dynamic>)["name"][0]),
                          ),
                          Space.width(20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text((userData)["name"] ?? ""),
                                Text("${userData["number"]}"),
                              ],
                            ),
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
