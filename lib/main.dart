import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project01/MVC/view/cartPage.dart';
import 'package:provider/provider.dart';

import 'MVC/controller/aouth_controller.dart';
import 'MVC/controller/db_conrtoller.dart';
import 'MVC/controller/home_controller.dart';
import 'MVC/controller/product_det_controller.dart';
import 'MVC/controller/profile_controller.dart';
import 'MVC/controller/sign_up_controller.dart';
import 'MVC/models/db_helper.dart';
import 'MVC/view/auth/loginPage.dart';
import 'MVC/view/auth/rejasterPage.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => DbController()),
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => SignUpController()),
        ChangeNotifierProvider(create: (context) => ProfileController()),
        ChangeNotifierProvider(create: (context) => ProductController()),


        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
     // theme: context.read<ProfileController>().isDark ? ThemeData.dark() : ThemeData.light(),

      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpPage(),
        '/main': (context) => const MainPage(),
        '/cart': (context) => const CartPage(),
        '/profile': (context) => const ProfilePage(),
        '/productDetails': (context) => const ProductDetails(),

      },
     initialRoute: '/main',
    ),
    );
  }
}


