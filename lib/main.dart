import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project01/Firebase/auth_firebase_Email.dart';
import 'package:project01/MVC/view/cartPage.dart';
import 'package:provider/provider.dart';

import 'MVC/controller/add_product_controller.dart';
import 'MVC/controller/aouth_controller.dart';
import 'MVC/controller/db_conrtoller.dart';
import 'MVC/controller/home_controller.dart';
import 'MVC/controller/productWhereCategory.dart';
import 'MVC/controller/product_det_controller.dart';
import 'MVC/controller/profile_controller.dart';
import 'MVC/controller/sign_up_controller.dart';
import 'MVC/models/db_helper.dart';
import 'MVC/view/all_Product.dart';
import 'MVC/view/auth/loginPage.dart';
import 'MVC/view/auth/rejasterPage.dart';
import 'MVC/view/category.dart';
import 'MVC/view/homePage.dart';
import 'MVC/view/mainPage.dart';
import 'MVC/view/product_details.dart';
import 'MVC/view/profile.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DbHelper.dbHelper.initDatabase();
  runApp(
        MyApp(),
  );
}

class MyApp extends StatelessWidget {

   MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DbController()),
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => SignUpController()),
        ChangeNotifierProvider(create: (context) => ProfileController()),
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => ProductCategoryController()),
        ChangeNotifierProvider(create: (context) => APController()),
        ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',


      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpPage(),
        '/main': (context) => const MainPage(),
        '/cart': (context) => const CartPage(),
        '/profile': (context) => const ProfilePage(),
        '/productDetails': (context) => const ProductDetails(),
         '/categoryPage': (context) => const CategoryResult(),
        '/products' : (context) => const Products(),

      },
      initialRoute: FbAuthController().isLogin ? '/main' : '/login',
    ),
    );
  }
}


