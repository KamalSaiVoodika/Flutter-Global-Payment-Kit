import 'dart:convert';
import 'package:mystarter/constants/style_data.dart';
import 'package:http/http.dart' as http;

class ApiChecker {
  static void checkApi(http.Response response) {
    if (response.statusCode == 401) {
     // Get.find<AuthController>().clearSharedData();
    //  Get.to(() => LogInScreen(),);
      final responseJson = jsonDecode(response.body);
      if (responseJson['message'] != null) {
        showCustomSnackBar(responseJson['message']);
      } else {
        showCustomSnackBar(responseJson['error']);
      }
    } else {
      final responseJson = jsonDecode(response.body);
      if (responseJson['message'] != null) {
        showCustomSnackBar(responseJson['message']);
      } else {
        showCustomSnackBar(responseJson['error']);
      }
    }
  }
}