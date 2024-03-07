import 'package:flutter/material.dart';

import 'package:s_medi/general/consts/colors.dart';

import '../../category/view/category_view.dart';
import '../../settings/view/setting_view.dart';
import '../../total_appintment/view/total_appointment_view.dart';
import 'home_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  List screenList = [
    const HomeScreen(),
    const CategoryScreenn(),
    const TotalAppointment(),
    const SettingsView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primeryColor,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: "Category"),
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range), label: "Appointments"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
