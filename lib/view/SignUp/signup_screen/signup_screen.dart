import 'package:api_practice_app/view/Login/login_screen/login_screen.dart';
import 'package:api_practice_app/view/SignUp/signup_controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final SignupController controller = Get.put(SignupController());
  final nameController = TextEditingController();
  final emailController =TextEditingController();
  final passwordController =TextEditingController();
  final confirmPasswordController =TextEditingController();

  void SubmitForm(){
    if(formKey.currentState!.validate()){
      controller.signUpUser(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
      ),
      body:Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(),
                  ),
                  hintText: "Enter your name",
                ),
              ),

              SizedBox(height: 10,),
              TextFormField(
                 controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(),
                  ),
                  hintText: "Enter your email",
                ),
              ),

              SizedBox(height: 10,),
              TextFormField(
                 controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(),
                  ),
                  hintText: "Enter your password",
                ),
              ),

              SizedBox(height: 10,),
              TextFormField(
                 controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(),
                  ),
                  hintText: "Confirm password",
                ),
              ),

              SizedBox(height: 20,),
              Row(
                children: [
                  Text("Already Have a Account ? "),
                  GestureDetector(
                      onTap: (){
                        Get.to(LoginScreen());
                      },
                      child: Text("Login",style: TextStyle(color: Colors.blue),)
                  )
                ],
              ),
              SizedBox(height: 20,),
              Obx((){
                return ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.amberAccent)
                  ),
                  onPressed: controller.isLoading.value ? null : (){
                    SubmitForm();
                    print("Register");
                  },
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("SignUp",style: TextStyle(color: Colors.black),),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
