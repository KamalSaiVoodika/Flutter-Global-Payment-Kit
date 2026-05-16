import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mystarter/constants/images.dart';
import 'package:mystarter/constants/size_config.dart';
import 'package:mystarter/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/home_screen.dart';
import '../intro/intro_pages.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  final box = GetStorage();

  @override
  void initState() {
    SharedPreferences.getInstance().then((pr) {
      prefs = pr;
    });
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animationController.forward();
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animation.addListener(() => setState(() {}));
    _animationController.forward();
    Timer(const Duration(seconds: 3), () {
      navigation();
    });
    super.initState();
  }

  void navigation() async {
    if (box.read('intro') == true) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const IntroPages());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation as Animation<double>,
          child: Hero(
            tag: 'logo',
            child: Image.asset(
              Images.logo,
              width: _animation.value * getProportionateScreenWidth(200),
              height: _animation.value * getProportionateScreenWidth(200),
            ),
          ),
        ),
      ),
    );
  }
}
