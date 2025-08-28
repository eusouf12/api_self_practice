import 'package:api_practice_app/view/AddTask/add_task_controller/add_task_controller.dart';
import 'package:api_practice_app/view/MyTask/my_task_screen/my_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final AddTaskController controller = Get.put(AddTaskController());
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void taskSubmit() {
    if (formKey.currentState!.validate()) {
      controller.addTask(
        title: titleController.text,
        description: descriptionController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Center(child: Text("Add Task",))),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Task Title",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Enter Task Title",
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Description",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                    hintText: "Enter Task Description",
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 20),
        
                Obx(() {
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.amberAccent),
                    ),
        
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            Get.defaultDialog(
                              title: "Are you sure you want to add this task?",
                              titleStyle: TextStyle(fontSize: 16),
                              middleText: "",
                              confirm: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(Colors.cyan),
                                ),
                                onPressed: () {
                                  taskSubmit();
                                  Get.to(MyTaskScreen());
                                },
                                child: Text("Add Task", style: TextStyle(color: Colors.black)),
                              ),
                              cancel: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Cancel", style: TextStyle(color: Colors.black)),
                              ),
                            );
                          },
                    child: Center(
                      child: controller.isLoading.value
                          ? CircularProgressIndicator()
                          : Text("Add Task", style: TextStyle(color: Colors.black)),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
