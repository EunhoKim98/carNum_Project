import 'package:flutter/material.dart';
import 'package:car/views/car_search_screen.dart';
import 'package:car/views/setting_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MainPage extends StatefulWidget {
   const MainPage({super.key});

   @override
   State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
   int _currentIndex = 0;

   final List<Widget> _screens = [
      CarSearchScreen(),
      SettingScreen(),
   ];

   @override
   Widget build(BuildContext context) {
      SvgPicture svgIcon(String src, {Color? color}) {
         return SvgPicture.asset(
            src,
            height: 24,
            colorFilter: ColorFilter.mode(
                color ??
                    Theme.of(context).iconTheme.color!.withOpacity(
                        Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
                BlendMode.srcIn),
         );
      }


      return SafeArea(
         child: Scaffold(
            appBar: AppBar(
               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
               leading: const SizedBox(),
               leadingWidth: 0,
               centerTitle: false,
                title: SvgPicture.asset(
                   "assets/images/logo_1024.svg",
                   colorFilter: ColorFilter.mode(
                       Theme.of(context).iconTheme.color!, BlendMode.srcIn),
                   height: 20,
                   width: 300,
                ),
               actions: [

               ],
            ),


            body:
            _screens[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
               currentIndex: _currentIndex,
               onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
               },
               items: [
                  BottomNavigationBarItem(
                     icon: Icon(Icons.car_crash),
                     label: "침수차검색",
                  ),
                  BottomNavigationBarItem(
                     icon: Icon(Icons.settings),
                     label: "설정"
                  ),
               ],
            ),
         ),
      );
   }
}
