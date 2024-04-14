import 'package:get/get.dart';

import '../controllers/voice_call_agora_controller.dart';

class VoiceCallAgoraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoiceCallAgoraController>(
      () => VoiceCallAgoraController(),
    );
  }
}
