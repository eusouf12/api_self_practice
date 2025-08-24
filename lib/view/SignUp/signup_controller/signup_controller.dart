
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class SignupController extends GetxController{
  final isLoading = false.obs;
  
  
  Future<void> signUpUser(
  {
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    File?file,
  })async{
    isLoading.value = true;
     try{
      final response = await post(Uri.parse("http://172.252.13.83:2000/api/v1/users"),
        headers: {
        'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Get.snackbar(
          "Success",
          "SignUp successful!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

      } else {
        final errorData = jsonDecode(response.body);
        String errorMessage = errorData['message'] ?? 'SignUp failed';
        Get.snackbar(
          "Error",
          errorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }catch (e){
      Get.snackbar(
        "Error",
        "Network error: ${e.toString()}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }finally{
      isLoading.value = false;
    }
  }

}