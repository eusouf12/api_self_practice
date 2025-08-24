import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'dart:convert'; // ADDED: For JSON handling

class LoginController extends GetxController {
  var isLoading = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void loginApi() async {
    isLoading.value = true;

    try {
      final response = await post(
        Uri.parse("http://172.252.13.83:2000/api/v1/auth/login"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": emailController.text,
          "password": passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Get.snackbar(
          "Success",
          "Login successful!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

      } else {
        final errorData = jsonDecode(response.body);
        String errorMessage = errorData['message'] ?? 'Login failed';
        Get.snackbar(
          "Error",
          errorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Network error: ${e.toString()}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}