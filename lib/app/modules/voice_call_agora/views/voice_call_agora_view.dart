// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// // import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// // import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
//
//
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../controllers/voice_call_agora_controller.dart';
//
// String agoraAppId = "b9afe1385e4a452dba0a1cdf52cc7bdc";
// String tempToken = "007eJxTYDDcccThnZEbM7s+f7vo+zqGlHD18iU/vwg7vb6RZ+r89oUCQ5JlYlqqobGFaapJoompUUpSokGiYXJKmqlRcrJ5Ukry1mzJtIZARoaliR7MjAwQCOKzMiTmZhZnMDAAAA2RHyE=";
//
//
// // class VoiceCallAgoraView extends GetView<VoiceCallAgoraController> {
// //   const VoiceCallAgoraView({Key? key}) : super(key: key);
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('VoiceCallAgoraView'),
// //         centerTitle: true,
// //       ),
// //       body: const Center(
// //         child: Text(
// //           'VoiceCallAgoraView is working',
// //           style: TextStyle(fontSize: 20),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// class VoiceCallPagee extends StatefulWidget {
//
//   const VoiceCallPagee({Key? key,}) : super(key: key);
//
//   @override
//   State<VoiceCallPagee> createState() => _VoiceCallPageeState();
// }
//
// class _VoiceCallPageeState extends State<VoiceCallPagee> {
//   int remoteUid = -1;
//   late RtcEngine rtcEngine;
//
//   @override
//   void initState() {
//     initForAgora();
//     super.initState();
//   }
//
//   Future<void> initForAgora() async {
//     await [Permission.microphone, Permission.camera].request();
//     // rtcEngine = await RtcEngine.create();
//     // rtcEngine = await RtcEngine.create(agoraAppId);
//
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('VoiceCallAgoraView'),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           Center(
//             child: _renderRemoteVideo(),
//           ),
//           Align(
//             alignment: Alignment.topLeft,
//             child: Container(
//               width: 100,
//               height: 100,
//               child: Center(child: _renderLocalPreview(),),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//
//   Widget _renderLocalPreview() {
//     return Container();
//   }
//
//   Widget _renderRemoteVideo({String? remoteUid}) {
//     if (remoteUid != null) {
//       return Container();
//     } else {
//       return const Text(
//           "Please wait remote user to join.", textAlign: TextAlign.center);
//     }
//   }
//
// }