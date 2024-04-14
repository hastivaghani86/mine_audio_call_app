import 'package:get/get.dart';

import '../controllers/calling_controller.dart';

class CallingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallingController>(
      () => CallingController(),
    );
  }
}
