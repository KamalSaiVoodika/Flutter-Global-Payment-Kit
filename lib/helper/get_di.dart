import 'package:get/get.dart';
import 'package:mystarter/controler/theme_controller.dart';
import 'package:mystarter/main.dart';
import 'package:mystarter/services/api/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api/api_client.dart';
import '../services/repository/test_repo.dart';

Future<void> init() async {
  /// Core
  prefs = await SharedPreferences.getInstance();
  Get.lazyPut(
    () => prefs,
  );
  Get.lazyPut(() => ApiClient(appBaseUrl: baseUrl), fenix: true);

  /// theme Controller
  Get.lazyPut(
    () => ThemeController(),
    fenix: true,
  );

  /// Repositories
  Get.lazyPut(
    () => TestRepo(
      apiClient: Get.find(),
    ),
    fenix: true,
  );

  /// sqlite database controllers

  /// Controllers
}
