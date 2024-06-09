import 'dart:io';

import 'package:brisk/localization/localization_const.dart';
import 'package:brisk/pages/Account/account.dart';
import 'package:brisk/pages/deposit/deposit.dart';
import 'package:brisk/pages/home/home_agent.dart';
import 'package:brisk/pages/loans/loans.dart';
import 'package:brisk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BottomNavigationAgentScreen extends StatefulWidget {
  const BottomNavigationAgentScreen({super.key, this.id});

  final int? id;

  @override
  State<BottomNavigationAgentScreen> createState() => _BottomNavigationAgentScreenState();
}

class _BottomNavigationAgentScreenState extends State<BottomNavigationAgentScreen> {
  int? currentPage;

  DateTime? backPressTime;

  @override
  void initState() {
    setState(() {
      currentPage = widget.id ?? 0;
    });
    super.initState();
  }

  final pages = [
    const HomeAgentScreen(),
    const DepositScreen(),
    const LoansScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool backStatus = onWillPop();
        if (backStatus) {
          exit(0);
        } else {
          return false;
        }
      },
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          body: pages.elementAt(currentPage!),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: primaryColor,
            unselectedItemColor: grey94Color,
            selectedLabelStyle: bold15Primary,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            unselectedLabelStyle: bold15Grey94,
            currentIndex: currentPage!,
            onTap: (index) {
              setState(() {
                currentPage = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined),
                  label: getTranslation(context, 'bottom_navigation.home')),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/bottomNavigation/Glyph_ undefined.png",
                    height: 24,
                    width: 24,
                    color: grey94Color,
                    fit: BoxFit.cover,
                  ),
                  activeIcon: Image.asset(
                    "assets/bottomNavigation/Glyph_ undefined.png",
                    height: 24,
                    width: 24,
                    color: primaryColor,
                    fit: BoxFit.cover,
                  ),
                  label: getTranslation(context, 'bottom_navigation.deposit')),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/bottomNavigation/money-16-regular.png",
                    height: 24,
                    width: 24,
                    color: grey94Color,
                    fit: BoxFit.cover,
                  ),
                  activeIcon: Image.asset(
                    "assets/bottomNavigation/money-16-regular.png",
                    height: 24,
                    width: 24,
                    color: primaryColor,
                    fit: BoxFit.cover,
                  ),
                  label: getTranslation(context, 'bottom_navigation.loans')),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.person_outline),
                  label: getTranslation(context, 'bottom_navigation.account'))
            ],
          ),
        ),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (backPressTime == null ||
        now.difference(backPressTime!) >= const Duration(seconds: 2)) {
      backPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: blackColor,
          content: Text(
            getTranslation(context, 'exit_app.app_exit'),
            style: snackBarStyle,
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 1500),
        ),
      );
      return false;
    } else {
      return true;
    }
  }
}
