import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mystarter/services/api/app_config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mystarter/constants/theme/dark_theme.dart';
import 'package:mystarter/constants/theme/light_theme.dart';
import 'package:mystarter/controler/theme_controller.dart';
import 'package:mystarter/helper/get_di.dart';
import 'package:mystarter/services/localization_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/strings.dart';
import 'view/screens/splash/splash_screen.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //init get storage
  await GetStorage.init();
  //Dependency Injection
  await init();
  //stripe
  Stripe.publishableKey = kPublishableKey;
  Stripe.merchantIdentifier = "App Identifier";
  await Stripe.instance.applySettings();
  //Init my app
  runApp(const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: appName,
          theme: themeController.darkTheme ? dark : light,
          translations: LocalizationService(),
          locale: LocalizationService().getCurrentLocale(),
          fallbackLocale: const Locale(
            'en',
            'US',
          ),
          home: const SplashScreen(),
          transitionDuration: 300.milliseconds,
          defaultTransition: Transition.rightToLeft,
        );
      },
    );
  }
}
