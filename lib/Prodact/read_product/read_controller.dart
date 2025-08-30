import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart';

class ReadProductController extends GetxController {
  final isLoading = false.obs;
  final myProducts = [].obs;
  
  Future<void> readProduct() async{
    try{
      isLoading.value = true;
      final response = await get(Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct"),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if(response.statusCode == 200){
        final responseData = jsonDecode(response.body);
        final data = responseData['data'] ??[];
        myProducts.assignAll(data);
      }
    }catch (e){
      print(e.toString());
    }
    finally {
      isLoading.value = false;
    }
  }
}