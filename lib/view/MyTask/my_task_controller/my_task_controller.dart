import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class MyTaskController extends GetxController{
  final myTasks = [].obs;
  final isLoading = false.obs;
  final box = GetStorage();

  Future<void> myTasksApi()async{
    final token = box.read("token");

     try{
       isLoading.value = true;
       final response = await get(Uri.parse("http://172.252.13.83:2000/api/v1/task/my-tasks"),
         headers: {
           "Authorization": "Bearer $token",
           "Content-Type": "application/json",
         },
       );
       if (response.statusCode == 200) {
         final responseData = jsonDecode(response.body);
         myTasks.assignAll(responseData['data']?['data'] ?? []);

       }
     } catch (e){
      print(e.toString());
    }
     finally {
       isLoading.value = false;
     }
  }
}