import 'package:api_practice_app/Prodact/delete_product/delete_controller.dart';
import 'package:api_practice_app/Prodact/update_product/update_screen.dart';
import 'package:get/get.dart';
import 'package:api_practice_app/Prodact/read_product/read_controller.dart';
import 'package:flutter/material.dart';

class ReadProductScreen extends StatefulWidget {
  const ReadProductScreen({super.key});

  @override
  State<ReadProductScreen> createState() => _ReadProductScreenState();
}

class _ReadProductScreenState extends State<ReadProductScreen> {
  final ReadProductController controller = Get.put(ReadProductController());
  final DeleteController deleteController = Get.put(DeleteController());

  @override
  void initState() {
    super.initState();
    controller.readProduct();
  }

  deleteItem(String id) async {
    await deleteController.deleteProduct(id);
    await controller.readProduct();
  }

  updateItem(context,productItem){
    Get.to(() => UpdateScreen(productItem))!.then((result) {
      if (result == true) {
        controller.readProduct();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Show Products"))),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.myProducts.isEmpty) {
          return const Center(child: Text("No products found"));
        }

        return RefreshIndicator(
          onRefresh: () async {
            await controller.readProduct();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: GridView.builder(
              itemCount: controller.myProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: .55,
              ),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.myProducts[index]["Img"]?.isNotEmpty == true
                          ? Image.network(
                              controller.myProducts[index]["Img"],
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.image_not_supported,
                                    size: 100,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 50),
                                ],
                              ),
                            ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.myProducts[index]["ProductName"]
                                        ?.toString()
                                        .isNotEmpty ==
                                    true
                                ? controller.myProducts[index]["ProductName"]
                                : "",
                          ),
                          Text(
                            controller.myProducts[index]["ProductCode"]
                                        ?.toString()
                                        .isNotEmpty ==
                                    true
                                ? controller.myProducts[index]["ProductCode"]
                                : "",
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Unit Price : \$${controller.myProducts[index]["UnitPrice"] ?? "0"}",
                          ),
                          Text(
                            "Total Price : \$${controller.myProducts[index]["TotalPrice"] ?? "0"}",
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              updateItem(context,controller.myProducts[index],);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.purpleAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text("Update"),
                            ),
                          ),
                          // update btn
                          GestureDetector(
                            onTap: () async {
                              Get.defaultDialog(
                                title: "Are you sure?",
                                middleText: "Delete this product?",
                                textCancel: "Cancel",
                                textConfirm: "Confirm",
                                confirmTextColor: Colors.white,
                                buttonColor: Colors.red,
                                onCancel: () {},
                                onConfirm: () async {
                                  Get.back();
                                  await deleteItem(controller.myProducts[index]["_id"]);
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text("Delete"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
