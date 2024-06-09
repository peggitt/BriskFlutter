import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:brisk/localization/localization_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onboarding/onboarding.dart';

import '../../theme/theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  DateTime? backPressTime;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final pageModelList = [
      PageModel(
        widget: DecoratedBox(
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Column(
            children: [
              const Spacer(),
              Center(
                child: Image.asset(
                  "assets/onboarding/onboarding1.png",
                  width: size.height * 0.35,
                  height: size.height * 0.35,
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
                child: Text(
                  getTranslation(context, 'onboarding.text1'),
                  style: bold20Black33,
                  textAlign: TextAlign.center,
                ),
              ),
              height5Space,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: fixPadding * 2),
                child: Text(
                  "Banking on the go...",
                  textAlign: TextAlign.center,
                  style: semibold14Grey94,
                ),
              ),
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
            ],
          ),
        ),
      ),
      PageModel(
        widget: DecoratedBox(
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Column(
            children: [
              const Spacer(),
              Center(
                child: Image.asset(
                  "assets/onboarding/onboarding2.png",
                  width: size.height * 0.35,
                  height: size.height * 0.35,
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
                child: Text(
                  getTranslation(context, 'onboarding.text2'),
                  style: bold20Black33,
                  textAlign: TextAlign.center,
                ),
              ),
              height5Space,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: fixPadding * 2),
                child: Text(
                  "Step into a world of financial convenience by staying connected to your money. Take charge of your financial goals with our innovative mobile banking app.",
                  textAlign: TextAlign.center,
                  style: semibold14Grey94,
                ),
              ),
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
            ],
          ),
        ),
      ),
      PageModel(
        widget: DecoratedBox(
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Column(
            children: [
              const Spacer(),
              Center(
                child: Image.asset(
                  "assets/onboarding/onboarding1.png",
                  width: size.height * 0.35,
                  height: size.height * 0.35,
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
                child: Text(
                  getTranslation(context, 'onboarding.text3'),
                  style: bold20Black33,
                  textAlign: TextAlign.center,
                ),
              ),
              height5Space,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: fixPadding * 2),
                child: Text(
                  "Unlock the freedom of mobile banking: Seamlessly manage your accounts, make transactions, and stay connected no matter where you are with our on-the-go app.",
                  textAlign: TextAlign.center,
                  style: semibold14Grey94,
                ),
              ),
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
            ],
          ),
        ),
      ),
    ];
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
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFFFFFCFD),
          body: ListView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                width: size.width,
                height: size.height,
                child: Onboarding(
                  onPageChange: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  startPageIndex: currentPage,
                  pages: pageModelList,
                  footerBuilder: (context, dragDistance, pageLenght, setIndex) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        currentPage == pageLenght - 1
                            ? TextButton(
                                onPressed: null,
                                child: Text(
                                  getTranslation(context, 'onboarding.skip'),
                                  style: bold14Grey94.copyWith(
                                      color: Colors.transparent),
                                ),
                              )
                            : skipButton(context),
                        Row(
                          children: List.generate(
                            pageLenght,
                            (index) => _buildDot(index),
                          ),
                        ),
                        arrowButton(pageLenght, context),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  skipButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/login');
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith(
            (states) => primaryColor.withOpacity(0.1)),
      ),
      child: Text(
        getTranslation(context, 'onboarding.skip'),
        style: bold14Grey94,
      ),
    );
  }

  arrowButton(int pageLenght, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          if (currentPage == pageLenght - 1) {
            Navigator.pushNamed(context, '/login');
          } else {
            setState(() {
              currentPage++;
            });
          }
        },
        child: DottedBorder(
          borderType: BorderType.Circle,
          padding: const EdgeInsets.all(5),
          color: const Color(0xFFDA8BA3),
          dashPattern: const [2, 3],
          strokeWidth: 2,
          strokeCap: StrokeCap.square,
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                color: primaryColor, shape: BoxShape.circle),
            child: const Icon(Icons.arrow_forward, color: whiteColor),
          ),
        ),
      ),
    );
  }

  _buildDot(index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: fixPadding / 4),
      height: 8,
      width: currentPage == index ? 32 : 8,
      decoration: BoxDecoration(
        color: currentPage == index ? primaryColor : greyD9Color,
        borderRadius: BorderRadius.circular(30),
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
