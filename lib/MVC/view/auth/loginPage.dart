import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../widget/big_text.dart';
import '../../../widget/button.dart';
import '../../../widget/small_text.dart';
import '../../../widget/textFiled.dart';
import '../../controller/aouth_controller.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              children: [
                //Login
                Consumer<LoginController>(
                  builder: (context,controller,x)
                  => Container(
                    margin: const EdgeInsets.fromLTRB(15, 55, 15, 20),
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: const Offset(1, 5),
                          blurRadius: 10,
                          //spreadRadius: 5,
                        ),
                      ],
                    ),
                  //  child:  Form(
                    //  key: controller.formKeyLogin,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: BigText(text: 'Welcome,'),
                            subtitle: SmallText(text: 'Please login to continue'),
                            trailing: TextButton(
                              onPressed: () {
                                //Get.to(() => const SignUpPage());
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: const Text('sing',style: TextStyle(color: AppColors.buttonColor,fontSize:18),),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          SmallText(text: 'Email',fontSize: 14,),
                          TextFiledWidget(
                            valedtor:'email',
//
                            controller:controller.emailController,
                            onChang: (value)=>controller.emailController.text = value ,),
                          const SizedBox(height: 40,),

                          SmallText(text: 'Password',fontSize: 14,),


                         TextFiledWidget(
                           valedtor:  'Password',
                           keyboardType: TextInputType.visiblePassword,
                             obscureText: true,
                             hintText: '*******',
                             controller: controller.passwordController,
                           onChang: (value){}
                           //controller.passwordController.text = value,
                         ),


                          const SizedBox(height: 15,),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {

                              },
                              child: const Text('Forget Password?',style: TextStyle(fontSize:14,color: Colors.black),),
                            ),),
                          const SizedBox(height: 20,),
                          ButtonWidget(onpressed: (){
                            if (true) {
                              controller.context = context;
                              controller.login();
                            }

                          }, text: 'SING IN',)

                        ],
                      ),
                    ),
                ),
             //   ),

                //Login with




              ],
            )
        )

    );
  }
}
