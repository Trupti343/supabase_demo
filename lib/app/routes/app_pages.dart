import 'package:get/get.dart';

import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/crud/bindings/crud_binding.dart';
import '../modules/crud/views/crud_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/in_app_purchase/bindings/in_app_purchase_binding.dart';
import '../modules/in_app_purchase/views/in_app_purchase_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/merge_video/bindings/merge_video_binding.dart';
import '../modules/merge_video/views/merge_video_view.dart';
import '../modules/registration/bindings/registration_binding.dart';
import '../modules/registration/views/registration_view.dart';
import '../modules/users/bindings/users_binding.dart';
import '../modules/users/views/users_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => RegistrationView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.CRUD,
      page: () => CrudView(),
      binding: CrudBinding(),
    ),
    GetPage(
      name: _Paths.MERGE_VIDEO,
      page: () => MergeVideoView(),
      binding: MergeVideoBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () =>  ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
 
    GetPage(
      name: _Paths.USERS,
      page: () =>  UsersView(),
      binding: UsersBinding(),
    ),
    GetPage(
      name: _Paths.IN_APP_PURCHASE,
      page: () => InAppPurchaseView(),
      binding: InAppPurchaseBinding(),
    ),
  ];
}
