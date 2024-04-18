import 'package:get/get.dart';

import '../controllers/zego_audio_call_controller.dart';

class ZegoAudioCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZegoAudioCallController>(
      () => ZegoAudioCallController(),
    );
  }
}
