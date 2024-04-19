import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine/main.dart';
import 'package:mine/utils/all_keys.dart';
import 'package:mine/utils/app_key_storage.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';


class ZegoAudioCallView extends StatefulWidget {
  final String uid;
  final String name;
  // final String roomId;
  const ZegoAudioCallView(this.uid, this.name, /*this.roomId,*/  {Key? key}) : super(key: key);

  @override
  _ZegoAudioCallViewState createState() => _ZegoAudioCallViewState();
}

class _ZegoAudioCallViewState extends State<ZegoAudioCallView> with WidgetsBindingObserver {
  // ZegoAudioCallController controller = Get.find();
RxString roomId = "".obs;
  @override
  void initState() {
    roomId  .value= generateRoomId(widget.uid);
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  String generateRoomId(String uid1) {
     String uid2 = box.read(StorageKeys.uid);
    // Sort the UIDs to ensure that the order does not affect the output
    List<String> ids = [uid1, uid2];
    ids.sort();

    // Concatenate the sorted UIDs with a separator
    String roomId2 = ids.join('-');
print("ROOM ID ==> $roomId2");
    return roomId2;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed || state == AppLifecycleState.inactive) {
      // Handle call disconnect or cleanup here
      // call?.leaveRoom();  // Example method, adjust based on your SDK
      // Get.back();
      print("RESUMED");
    }else{
      print("state : $state");

      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      body: Stack(
        children: [
          ZegoUIKitPrebuiltCall(
            appID:  appId, // Consider fetching from a secure source
            appSign: appSecret, // Consider fetching from a secure source
            userID: widget.uid,
            userName: widget.name,
            callID: roomId.value,
            config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
          ),
        ],
      ),
    ), onWillPop: () async{return Future.value(false);

    });
  }
}
