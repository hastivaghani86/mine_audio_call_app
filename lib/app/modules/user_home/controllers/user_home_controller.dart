import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mine/utils/app_key_storage.dart';

import '../../../../main.dart';

class UserHomeController extends GetxController {

  List<dynamic> showIds =[];

  @override
  void onInit() async{
    showIds =  await getUserShowIds();
    update();
    print("SHOWID FOR USER : $showIds");
    super.onInit();
  }

  Future<List<dynamic>> getUserShowIds() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Retrieve user ID from GetStorage
    String? userId = box.read(StorageKeys.uid);
    if (userId == null) {
      throw Exception('User ID is not available in local storage');
    }

    try {
      // Fetch the user's document
      DocumentSnapshot userDoc = await firestore.collection('users').doc(userId).get();

      if (!userDoc.exists) {
        throw Exception('User document does not exist');
      }

      // Access the 'showId' field, which is a list
      List<dynamic> showIds = List<dynamic>.from(userDoc.get('showId') ?? []);
      return showIds;
    } catch (e) {
      print('Error retrieving user show IDs: $e');
      rethrow; // Rethrow to handle the exception elsewhere if necessary
    }
  }




}
