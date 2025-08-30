import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../read_product/read_product_screen.dart';

class AddProductController extends GetxController {

  final isLoading = false.obs;

  Future<void> addProduct({
    required String productName,
    required String productCode,
    required String productImage,
    required String unitPrice,
    required String totalPrice,
})async{
    isLoading.value = true;

    Map<String,dynamic> body = {
      "ProductName" : productName,
      "ProductCode": productCode,
      "Img": productImage,
      "TotalPrice": totalPrice,
      "unitPrice": unitPrice
    };

    try{
      final response = await post(Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
      );

      print("STATUS CODE: ${response.statusCode}");
      print("RESPONSE BODY: ${response.body}");

      if(response.statusCode == 200)
        {
          Get.snackbar("Success",
            "Product Add Successfully",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Future.delayed(Duration(seconds: 2), () {
            Get.to(() => ReadProductScreen());
          });
        }
      else{
        final errorData = jsonDecode(response.body);
        String errorMassage = errorData['message'] ?? "Fail to add Product";
        Get.snackbar(
            "error", errorMassage,
            backgroundColor: Colors.red,
            colorText: Colors.white
        );
      }
    }
    catch (e){
      Get.snackbar(
          "error",
         "Something went wrong: ${e.toString()}",
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
    }
    finally{
      isLoading.value = false;
    }
  }

}