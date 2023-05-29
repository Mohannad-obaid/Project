import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/colors.dart';
import '../../../widget/big_text.dart';
import '../../../widget/button.dart';
import '../../../widget/small_text.dart';
import '../../../widget/textFiled.dart';
import '../../controller/sign_up_controller.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.witheColor,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: AppColors.witheColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<SignUpController>(
          builder: (context,controller,x){
          return Container(
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: const Offset(1, 5),
                  blurRadius: 10,
                  //spreadRadius: 5,
                ),
              ],
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: 'Sign Up'),
                  const SizedBox(
                    height: 55,
                  ),
                  SmallText(
                    text: 'Name',
                    fontSize: 14,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFiledWidget(
                    onChang: (value) => controller.name.text = value,
                    valedtor: 'Name',
                    hintText: 'Name',
                    controller: controller.name,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SmallText(
                    text: 'Email',
                    fontSize: 14,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFiledWidget(
                    onChang: (value) => controller.emailController.text = value,
                    valedtor: 'email',
                    controller: controller.emailController,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SmallText(
                    text: 'Password',
                    fontSize: 14,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFiledWidget(
                    onChang: (value) => controller.passwordController.text = value,
                    valedtor: 'password',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    hintText: '*******',
                    controller: controller.passwordController,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ButtonWidget(
                    onpressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.context = context;
                        controller.create();
                      }
                    },
                    text: 'Sign Up',
                  ),
                ],
              ),
            ),
          );
  }
        ),
      ),
    );
  }
}
