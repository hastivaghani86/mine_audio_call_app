import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine/agora/agora_video_call.dart';
import 'package:mine/app/modules/zego_audio_call/views/zego_audio_call_view.dart';
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
                  return !controller.showIds.contains((userData as Map<String, dynamic>)["id"] )  ? const SizedBox(): Container(
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
                        GestureDetector(
                          onTap: () {
                            Get.to(()=>ZegoAudioCallView((userData)["id"], (userData)["name"], "test"));
                            // Get.to(()=>AgoraVideoCallExa(remoteUid: /*(userData)["id"]*/123,));
                            // Get.toNamed(Routes.CALLING);
                          },
                          child: Container(alignment: Alignment.center,
                            width: 50,
                            height: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              // color: AppColor.primaryColor,
                                shape: BoxShape.circle),
                            child: const Icon(Icons.call),
                          ),
                        )
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
