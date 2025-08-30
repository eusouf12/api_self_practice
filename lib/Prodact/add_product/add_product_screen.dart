import 'package:api_practice_app/Prodact/add_product/add_controllert.dart';
import 'package:api_practice_app/Prodact/read_product/read_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final AddProductController controller = Get.put(AddProductController());
  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final productCodeController = TextEditingController();
  final productImageController = TextEditingController();
  final unitPriceController = TextEditingController();
  final totalPriceController = TextEditingController();

  void submitProduct() {
    if (formKey.currentState!.validate()) {
      controller.addProduct(
        productName: productNameController.text,
        productCode: productCodeController.text,
        productImage: productImageController.text,
        unitPrice: unitPriceController.text,
        totalPrice: totalPriceController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Add Product"))),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(
                    hintText: "Product Name",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                TextFormField(
                  controller: productCodeController,
                  decoration: InputDecoration(
                    hintText: "Product Code",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                TextFormField(
                  controller: productImageController,
                  decoration: InputDecoration(
                    hintText: "Product Image",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                TextFormField(
                  controller: unitPriceController,
                  decoration: InputDecoration(
                    hintText: "Unit Price",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                TextFormField(
                  controller: totalPriceController,
                  decoration: InputDecoration(
                    hintText: "Total Price",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Obx(() {
                  return ElevatedButton(
                    onPressed:controller.isLoading.value ? null : () {
                      submitProduct();
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.amberAccent),
                    ),
                    child: Center(
                      child: controller.isLoading.value
                          ? CircularProgressIndicator()
                          : Text("Add Product", style: TextStyle(color: Colors.black)),
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
