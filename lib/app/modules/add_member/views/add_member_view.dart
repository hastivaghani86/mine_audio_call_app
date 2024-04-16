import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mine/utils/app_button.dart';
import 'package:mine/utils/app_color.dart';
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

                    },
                    child:Container(
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
                                (userData as Map<String, dynamic>)["name"][0]),
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
