import 'package:get/get.dart';

import '../modules/add_member/bindings/add_member_binding.dart';
import '../modules/add_member/views/add_member_view.dart';
import '../modules/calling/bindings/calling_binding.dart';
import '../modules/calling/views/calling_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login_user/bindings/login_user_binding.dart';
import '../modules/login_user/views/login_user_view.dart';
import '../modules/user_home/bindings/user_home_binding.dart';
import '../modules/user_home/views/user_home_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    // GetPage(
    //   name: _Paths.LOGIN_USER,
    //   page: () => const LoginUserView(),
    //   binding: LoginUserBinding(),
    // ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //   name: _Paths.ADMIN_USER_WISE_NUMBER,
    //   page: () => const AdminUserWiseNumberView(),
    //   binding: AdminUserWiseNumberBinding(),
    // ),
    GetPage(
      name: _Paths.USER_HOME,
      page: () => const UserHomeView(),
      binding: UserHomeBinding(),
    ),
    GetPage(
      name: _Paths.CALLING,
      page: () => const CallingView(),
      binding: CallingBinding(),
    ),
    GetPage(
      name: _Paths.ADD_MEMBER,
      page: () => const AddMemberView(),
      binding: AddMemberBinding(),
    ),
  ];
}
