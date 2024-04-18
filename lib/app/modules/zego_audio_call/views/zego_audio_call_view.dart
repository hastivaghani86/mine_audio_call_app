import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../controllers/zego_audio_call_controller.dart';

class ZegoAudioCallView extends GetView<ZegoAudioCallController> {
  final String uid;
  final String name;
  final String roomId;
  const ZegoAudioCallView(this.uid, this.name, this.roomId, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          ZegoUIKitPrebuiltCall(
            appID: 856242764 /*input your AppID*/,
            appSign: "4ef56426c1176809221d36f8d2a74ebbd463af80f25f961d7498650f8372816d" /*input your AppSign*/,
            userID: uid,
            userName: name,
            callID: roomId,
            config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
              // ..onOnlySelfInRoom = (context) {
              //   if (PrebuiltCallMiniOverlayPageState.idle != ZegoUIKitPrebuiltCallMiniOverlayMachine().state()) {
              //     /// in minimizing
              //     ZegoUIKitPrebuiltCallMiniOverlayMachine().changeState(PrebuiltCallMiniOverlayPageState.idle);
              //   }
              // }

            /// support minimizing
              ..topMenuBarConfig.isVisible = false
              ..topMenuBarConfig.buttons = [
                // ZegoMenuBarButtonName.minimizingButton,
                // ZegoMenuBarButtonName.showMemberListButton,
              ],
          ),

        ]));
  }
}
