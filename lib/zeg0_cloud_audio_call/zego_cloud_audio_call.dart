//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart' hide navigator;
//
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
//
// const int appId = 1455035955;
// const String appSign = "a57f3fb8385944b5b5509300b24eab046b9d09cafaa0a37da753ea2df98cd6aa";
//
//
// class VideoCallScreen extends GetWidget<VideoCallController> {
// const VideoCallScreen({super.key});
//
// @override
// Widget build(BuildContext context) {
// return Scaffold(
// body: Stack(children: [
// ZegoUIKitPrebuiltCall(
// appID: appId /*input your AppID*/,
// appSign: appSign /*input your AppSign*/,
// userID: controller.args["userID"],
// userName: controller.userName.value,
// callID: controller.args["roomID"],
// config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
// ..onOnlySelfInRoom = (context) {
// // controller.joinCall.value = "JOIN CALL";
// if (PrebuiltCallMiniOverlayPageState.idle != ZegoUIKitPrebuiltCallMiniOverlayMachine().state()) {
// /// in minimizing
// ZegoUIKitPrebuiltCallMiniOverlayMachine().changeState(PrebuiltCallMiniOverlayPageState.idle);
// } else {
// Navigator.of(context).pop();
// controller.callTimer?.cancel();
