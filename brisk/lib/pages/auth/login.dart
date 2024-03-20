import 'dart:convert';
import 'dart:io';

import 'package:brisk/localization/localization_const.dart';
import 'package:brisk/pages/Account/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:device_info/device_info.dart';
import '../../constants/constants.dart';
import '../../theme/theme.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();

  String phoneCode = '+254';

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
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  backgroundImageBox(size),
                  loginText(size),
                  loginDetails(size, context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginDetails(Size size, BuildContext context) {

    return Positioned(
      top: size.height * 0.16,
      left: 0,
      right: 0,
      child: Container(
        width: double.maxFinite,
        height: size.height * 0.63,
        padding: const EdgeInsets.symmetric(vertical: fixPadding * 2),
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
          padding: EdgeInsets.only(
              left: fixPadding * 2,
              right: fixPadding * 2,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            heightSpace,
            image(size),
            heightSpace,
            heightSpace,
            welcomeText(),
            contentText(),
            heightSpace,
            heightSpace,
            heightSpace,
            height5Space,
            phoneField(context),
            heightSpace,
            heightSpace,
            heightSpace,
            heightSpace,
            loginButton(size),
            heightSpace,
            heightSpace,
            height5Space,
          ],
        ),
      ),
    );
  }

  loginText(Size size) {
    return Positioned(
      top: size.height * 0.09,
      left: 0,
      right: 0,
      child: Text(
        getTranslation(context, 'login.login'),
        style: bold25White,
        textAlign: TextAlign.center,
      ),
    );
  }

  title() {
    return const Text(
      "BRISK v1.01",
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

  loginButton(Size size) {
    return GestureDetector(
      onTap: () async {
        AppMobile='';
        String identifier = await getUniqueIdentifier();
        String ePhone = phoneController.text;
        ePhone=phoneCode+ePhone;
        Map<String, String> requestBody = {
          'MobileNumber': ePhone,
          'DeviceNumber': deviceCode,
          'AccType': 'USSD'
        };
        //print('First');
        try {
          var response = await http.post(
            Uri.parse(APILogin1),
            body: jsonEncode(requestBody),
            headers: {'Content-Type': 'application/json'},
          );
          int statusCode = response.statusCode;
          Map<String, dynamic> jsonResponse = json.decode(response.body);
          //print(jsonResponse);

          if (statusCode == 412)
          {
            AppMobile=ePhone;
            if (jsonResponse['detail'] == 'Login') {
              Navigator.pushNamed(context, '/loginactive');
            }else
              {
                Navigator.pushNamed(context, '/register');
              }
            showErrorMessage('Please provide the log-in pin details');
          } else if (statusCode == 403)
          {
            AppMobile=ePhone;
            Navigator.pushNamed(context, '/register');
            showErrorMessage('Please provide the sign up details');
          } else if (statusCode == 202 || statusCode == 200)
          {

            AppMobile=ePhone;
            Navigator.pushNamed(context, '/loginactive');
            //Navigator.pushNamed(context, '/enterpin');
            showErrorMessage('Welcome. Please enter your pin');
          } else {
            AppMobile='';
            showErrorMessage('Unable to proceed. Kindly try again later');
          }

        } catch (error) {
      // Handle network-related errors
          showErrorMessage('Network error during Login: $error');
        }



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
          getTranslation(context, 'login.login'),
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
      getTranslation(context, 'login.text'),
      style: semibold14Grey94,
      textAlign: TextAlign.center,
    );
  }

  welcomeText() {
    return Text(
      getTranslation(context, 'login.welcome_back'),
      style: bold18Black33,
      textAlign: TextAlign.center,
    );
  }

  phoneField(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
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
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: primaryColor,
          ),
        ),
        child: IntlPhoneField(
          disableLengthCheck: true,
          dropdownTextStyle: semibold16Black33,
          textAlign: selectedValue == 'عربى' ? TextAlign.right : TextAlign.left,
          showCountryFlag: false,
          initialCountryCode: 'KE',
          dropdownIconPosition: IconPosition.trailing,
          dropdownIcon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 20,
            color: black33Color,
          ),
          onChanged: (phone) {
            setState(() {
              phoneCode = phone.countryCode;
            });
          },
          onTap: () {
            print('Tapped');
            setState(() {
              phoneController.clear();
            });
          },
          controller: phoneController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: getTranslation(context, 'login.enter_number'),
            hintStyle: semibold16Grey94,
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

  Future<String> getUniqueIdentifier() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Theme
        .of(context)
        .platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceCode =  androidInfo.androidId; // IMEI/MEID
      return androidInfo.androidId;
    } else if (Theme
        .of(context)
        .platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      deviceCode =  iosInfo.identifierForVendor; // IDFV (Identifier for Vendor)
      return iosInfo.identifierForVendor;
    }
    deviceCode = 'Unknown';
    return 'Unknown';
  }


  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          content: Text(message),
          backgroundColor: Colors.blue, // Optional background color
          behavior: SnackBarBehavior.floating, // Optional behavior
        )
    );
  }

  void showPopupMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert..'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
