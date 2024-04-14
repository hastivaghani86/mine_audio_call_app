import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_size_config.dart';
import '../controllers/admin_user_wise_number_controller.dart';

class AdminUserWiseNumberView extends GetView<AdminUserWiseNumberController> {
  // final AsyncSnapshot<QuerySnapshot> snapshot;
  final List<dynamic> containsIds;
  final String user;
  final String docId;

  const AdminUserWiseNumberView(
      {
      //   required this.snapshot,
      required this.docId,
      required this.containsIds,
      required this.user,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diary of $user"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StreamBuilder(
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
                  // List<dynamic> containsIds = userData["showId"];
                  var userData = snapshot.data!.docs[index].data();
                  return (userData as Map<String, dynamic>)["id"] == docId
                      ? const SizedBox()
                      : Container(
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
                                child: Text((userData)["name"][0]),
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
                              !(containsIds.contains((userData)["id"]))
                                  ? InkWell(
                                      onTap: () async {
                                        // print("====> $docId ${userData["showId"]} ==> ${(userData)["id"]} ");
                                        // FirebaseFirestore.instance.collection("users").doc(docId).update(
                                        //     {"showId":userData["showId"].add((userData)["id"])});
                                        print("Adding ID: ${(userData)["id"]}");
                                        String newId = (userData)[
                                            "id"]; // Get the ID to add

                                        // Update the document in Firestore
                                        try {
                                          // Get a reference to the user document
                                          DocumentReference userDocRef =
                                              FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(docId);

                                          List<dynamic> currentShowIds =
                                              containsIds;

                                          // Add the new ID to the list if it's not already present
                                          if (!currentShowIds.contains(newId)) {
                                            currentShowIds.add(newId);

                                            // Update the document with the new "showId" value
                                            await userDocRef.update(
                                                {"showId": currentShowIds});
                                            print("ID added successfully.");
                                          } else {
                                            print(
                                                "ID already exists in the list.");
                                          }
                                        } catch (e) {
                                          print("Error adding ID: $e");
                                        }
                                      },
                                      child: Text("add"))
                                  : InkWell(
                                      onTap: () async {
                                        // print("====> $docId ${userData["showId"]} ==> ${(userData)["id"]} ");
                                        // FirebaseFirestore.instance.collection("users").doc(docId).update(
                                        //     {"showId":userData["showId"].add((userData)["id"])});
                                        print("Adding ID: ${(userData)["id"]}");
                                        String newId = (userData)[
                                            "id"]; // Get the ID to add

                                        // Update the document in Firestore
                                        try {
                                          // Get a reference to the user document
                                          DocumentReference userDocRef =
                                              FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(docId);

                                          List<dynamic> currentShowIds =
                                              containsIds;

                                          // Add the new ID to the list if it's not already present
                                          if (currentShowIds.contains(newId)) {
                                            currentShowIds.remove(newId);

                                            // Update the document with the new "showId" value
                                            await userDocRef.update(
                                                {"showId": currentShowIds});
                                            print("ID Removed successfully.");
                                          } else {
                                            print("ID not exists in the list.");
                                          }
                                        } catch (e) {
                                          print("Error adding ID: $e");
                                        }
                                      },
                                      child: Text("Remove"))
                            ],
                          ),
                        );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
