import 'package:api_practice_app/view/SignUp/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../login_controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final RxBool isChecked = false.obs;
  final LoginController controller = Get.put(LoginController());
  final formKey =GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void submitForm(){
    if(formKey.currentState!.validate()){
      controller.loginApi(
          email: emailController.text,
          password: passwordController.text
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Login Page")),
      ),


      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                validator: (a) => a!.isEmpty ? "Email is Require" : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(),
                  ),
                  hintText: "Enter your mail",
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                validator: (a) => a!.isEmpty ? "Password is Require" : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(),
                  ),
                  hintText: "Enter your password",
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("Don't Have a Account ? "),
                  GestureDetector(
                    onTap: (){
                      Get.to(SignupScreen());
                    },
                      child: Text("Sign Up",style: TextStyle(color: Colors.blue),)
                     )
                ],
              ),
              SizedBox(height: 20,),
              Obx((){
                return ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.greenAccent)
                  ),
                  onPressed: controller.isLoading.value ? null : () {
                    submitForm();
                  },
                  child: Center(
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Login",style: TextStyle(color: Colors.black),),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}