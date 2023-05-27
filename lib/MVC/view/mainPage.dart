import 'package:flutter/material.dart';
import 'package:project01/MVC/view/profile.dart';
import 'cartPage.dart';
import 'homePage.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _selectedIndex = 0;
  final PageController _pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children:   const [
          HomePage(),
          CartPage(),
          ProfilePage(),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          });
        },

        backgroundColor: Colors.white,


        showUnselectedLabels: false,
        showSelectedLabels: false,

        unselectedIconTheme: const IconThemeData(
          size: 25,
        ),

        selectedIconTheme: const IconThemeData(
          color: Colors.black,
        ),

        iconSize: 35,
        elevation: 0,



        items:     [
          BottomNavigationBarItem(
            icon: _selectedIndex != 0 ?  Image.asset('assets/icons/Icon_Explore.png',height: 25,width: 30,) : const ImageIcon( AssetImage('assets/icons/Explore.png'),),
            label: '',
          ),
          BottomNavigationBarItem(
            icon:  _selectedIndex != 1 ?  Image.asset('assets/icons/Icon_Cart.png',height: 25,width: 30,): const ImageIcon( AssetImage('assets/icons/Cart.png')),
            label: '',
          ),
          BottomNavigationBarItem(
            icon:  _selectedIndex != 2 ?   Image.asset('assets/icons/Icon_User.png',height: 25,width: 30,): const ImageIcon(AssetImage('assets/icons/Account.png')),
            label:  '',
          ),

        ],
      ),


    );
  }
}
