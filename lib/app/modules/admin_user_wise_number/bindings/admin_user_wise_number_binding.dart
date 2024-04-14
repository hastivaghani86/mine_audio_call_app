import 'package:get/get.dart';

import '../controllers/admin_user_wise_number_controller.dart';

class AdminUserWiseNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminUserWiseNumberController>(
      () => AdminUserWiseNumberController(),
    );
  }
}
