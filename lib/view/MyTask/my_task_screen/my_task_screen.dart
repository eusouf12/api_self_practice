import 'package:api_practice_app/view/MyTask/my_task_controller/my_task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTaskScreen extends StatefulWidget {
  const MyTaskScreen({super.key});

  @override
  State<MyTaskScreen> createState() => _MyTaskScreenState();
}

class _MyTaskScreenState extends State<MyTaskScreen> {
  final MyTaskController controller = Get.put(MyTaskController());

  @override
  void initState() {
    super.initState();
    controller.myTasksApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("My Task")),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.myTasks.isEmpty) {
          return const Center(child: Text("No tasks found"));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: List.generate(controller.myTasks.length, (index) {
                final task = controller.myTasks[index];
                return Column(
                  children: [
                    Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                       color: Colors.white
                     ),
                      padding: const EdgeInsets.all(20.0),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task['title'] ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(task['description'] ?? ""),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                );
              }),
            ),
          ),
        );
      }),
    );
  }
}
