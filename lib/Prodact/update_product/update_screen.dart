import 'package:api_practice_app/Prodact/update_product/update_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateScreen extends StatefulWidget {
  final Map<String, dynamic> productItem;

  const UpdateScreen(this.productItem, {super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final UpdateController controller = Get.put(UpdateController());
  final formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final productCodeController = TextEditingController();
  final productImageController = TextEditingController();
  final unitPriceController = TextEditingController();
  final totalPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    productNameController.text = widget.productItem["ProductName"] ?? '';
    productCodeController.text = widget.productItem["ProductCode"] ?? '';
    productImageController.text = widget.productItem["Img"] ?? '';
    unitPriceController.text = widget.productItem["UnitPrice"]?.toString() ?? '';
    totalPriceController.text = widget.productItem["TotalPrice"]?.toString() ?? '';
  }

  void updateProduct() {
    if (formKey.currentState!.validate()) {
      controller.updateProduct(
        productName: productNameController.text,
        productCode: productCodeController.text,
        productImage: productImageController.text,
        unitPrice: unitPriceController.text,
        totalPrice: totalPriceController.text,
        id: widget.productItem["_id"],
      );
      Get.back(result: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Update Product"))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: productCodeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: productImageController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: unitPriceController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: totalPriceController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Obx(() {
                  return ElevatedButton(
                    onPressed: controller.isLoading.value ? null : updateProduct,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amberAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Text(
                      "Update Product",
                      style: TextStyle(color: Colors.black, fontSize: 16),
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
