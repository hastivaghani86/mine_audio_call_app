import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine/app/modules/admin_user_wise_number/views/admin_user_wise_number_view.dart';
import 'package:mine/app/routes/app_pages.dart';
import 'package:mine/services/authentication_service.dart';
import 'package:mine/utils/app_size_config.dart';
import '../../../../utils/app_color.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Users'),
        actions: [
          InkWell(
              onTap: (){
                Get.toNamed(Routes.ADD_MEMBER);
              },
              child: const Icon(Icons.add)),
          PopupMenuButton<int>(
            onSelected: (val){
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
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var userData = snapshot.data!.docs[index].data();
                return InkWell(
                  onTap: (){
                    AsyncSnapshot<QuerySnapshot> snapshot2 = snapshot;
                    print(snapshot2);
                    List<dynamic> containsIds = userData["showId"] ?? [];
                    print("CONTAINS $containsIds");
                    print("==============================");
                    // Get.toNamed(Routes.ADMIN_USER_WISE_NUMBER);
                    //snapshot: snapshot,containsIds: containsIds
                    Get.to(()=>  AdminUserWiseNumberView(containsIds: containsIds,user:(userData)["name"] , docId: (userData)["id"],));
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
