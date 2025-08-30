import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class DeleteController extends GetxController{

  Future<void> deleteProduct(String id) async {
    try {
      final response = await get(
        Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/$id"),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Get.snackbar(
          "Success", "Product Delete Successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
      else {
        Get.snackbar(
          "Request Fail !", "Try Again",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
          "Error", e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
    }
  }

}