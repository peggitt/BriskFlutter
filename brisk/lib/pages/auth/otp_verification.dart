import 'dart:io';

import 'package:brisk/localization/localization_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

import '../../theme/theme.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  TextEditingController thirdController = TextEditingController();
  TextEditingController fourController = TextEditingController();

  DateTime? backPressTime;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        bool backStatus = onWillPop();
        if (backStatus) {
          exit(0);
        } else {
          return false;
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                backgroundImageBox(size),
                otpText(size),
                otpVerificationDetails(size, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  otpVerificationDetails(Size size, BuildContext context) {
    return Positioned(
      top: size.height * 0.16,
      left: 0,
      right: 0,
      child: Container(
        width: double.maxFinite,
        height: size.height * 0.63,
        padding: const EdgeInsets.all(fixPadding * 2),
        margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(50.0),
          boxShadow: [
            BoxShadow(
              color: blackColor.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          children: [
            heightSpace,
            image(size),
            heightSpace,
            contentText(),
            heightSpace,
            heightSpace,
            heightSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                firstField(context),
                secondField(context),
                thirdField(context),
                fourField(context),
              ],
            ),
            heightSpace,
            heightSpace,
            heightSpace,
            heightSpace,
            verifyButton(size),
            resendButton(),
          ],
        ),
      ),
    );
  }

  resendButton() {
    return Center(
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(
              (states) => primaryColor.withOpacity(0.1)),
        ),
        child: Text(
          getTranslation(context, 'otp.resend'),
          style: bold15Grey94,
        ),
      ),
    );
  }

  otpText(Size size) {
    return Positioned(
      top: size.height * 0.09,
      left: 0,
      right: 0,
      child: Text(
        getTranslation(context, 'otp.otp_verification'),
        style: bold25White,
        textAlign: TextAlign.center,
      ),
    );
  }

  title() {
    return const Text(
      "APEX BANK",
      style: interSemibold22Primary,
      textAlign: TextAlign.center,
    );
  }

  logo() {
    return Image.asset(
      "assets/splash/mdi_star-three-points-outline.png",
      height: 50,
      width: 50,
      color: primaryColor,
    );
  }

  backgroundImageBox(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ShapeOfView(
          height: size.height * 0.33,
          width: double.maxFinite,
          elevation: 0,
          shape: ArcShape(
            direction: ArcDirection.Outside,
            height: 35,
            position: ArcPosition.Bottom,
          ),
          child: Image.asset(
            "assets/auth/bgImage.png",
            fit: BoxFit.cover,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            logo(),
            height5Space,
            title(),
            heightSpace,
            heightSpace,
          ],
        ),
      ],
    );
  }

  verifyButton(Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/enterpin');
      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(fixPadding * 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor,
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslation(context, 'otp.verify'),
          style: bold18White,
        ),
      ),
    );
  }

  image(Size size) {
    return Center(
      child: Image.asset(
        "assets/auth/Mobile-login-bro.png",
        height: size.height * 0.15,
        width: size.height * 0.15,
        fit: BoxFit.cover,
      ),
    );
  }

  contentText() {
    return Text(
      getTranslation(context, 'otp.otp_text'),
      style: semibold14Grey94,
      textAlign: TextAlign.center,
    );
  }

  fourField(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: fixPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.25),
            blurRadius: 6,
          )
        ],
      ),
      child: TextField(
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: (value) {
          if (value.length == 1) {
            Navigator.pushNamed(context, '/enterpin');
          }
        },
        style: semibold20Primary,
        cursorColor: primaryColor,
        controller: fourController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  thirdField(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: fixPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.25),
            blurRadius: 6,
          )
        ],
      ),
      child: TextField(
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: semibold20Primary,
        cursorColor: primaryColor,
        controller: thirdController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  secondField(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: fixPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.25),
            blurRadius: 6,
          )
        ],
      ),
      child: TextField(
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: semibold20Primary,
        cursorColor: primaryColor,
        controller: secondController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  firstField(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: fixPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.25),
            blurRadius: 6,
          )
        ],
      ),
      child: TextField(
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: semibold20Primary,
        cursorColor: primaryColor,
        controller: firstController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  onWillPop() {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
