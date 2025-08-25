import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class AddTaskController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();

  Future<void> addTask({
    required String title,
    required String description,
  }) async {
    isLoading.value = true;

    final token = box.read("token");
    if (token == null) {
      Get.snackbar(
        "Error",
        "No token found. Please login again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
      return;
    }

    final body = {
      "title": title,
      "description": description,
    };

    try {
      final response = await post(Uri.parse("http://172.252.13.83:2000/api/v1/task"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      // Debug
      print("STATUS CODE: ${response.statusCode}");
      print("RESPONSE BODY: ${response.body}");

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        Get.snackbar(
          "Success",
          "Task  successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        final errorData = jsonDecode(response.body);
        String errorMessage = errorData['message'] ?? 'Failed to add task';
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
        "Something went wrong: ${e.toString()}",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
