import 'dart:async';
import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:brisk/localization/localization_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

import '../../constants/constants.dart';
import '../../theme/theme.dart';
import 'package:http/http.dart' as http;

class EnterPinScreen extends StatefulWidget {
  const EnterPinScreen({Key? key}) : super(key: key);

  @override
  State<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  TextEditingController thirdController = TextEditingController();
  TextEditingController fourController = TextEditingController();

  TextEditingController fifthController = TextEditingController();
  TextEditingController sixthController = TextEditingController();
  TextEditingController seventhController = TextEditingController();
  TextEditingController eightController = TextEditingController();
  String deviceCode = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            clipBehavior: Clip.antiAlias,
            children: [
              backgroundImage(size),
              backArrow(context),
              pintitle(size),
              enterPinDetails(size, context),
            ],
          ),
        ),
      ),
    );
  }

  enterPinDetails(Size size, BuildContext context) {
    return Positioned(
      top: size.height * 0.16,
      left: 0,
      right: 0,
      child: Container(
        width: double.maxFinite,
        height: size.height * 0.457,
        margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2, vertical: fixPadding),
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
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          physics: const BouncingScrollPhysics(),
          children: [
            heightSpace,
            heightSpace,
            welcomeText(),
            contentText(),
            heightSpace,
            heightSpace,
            heightSpace,
            height5Space,
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
            contentReenterText(),
            heightSpace,
            heightSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                fifthField(context),
                sixthField(context),
                seventhField(context),
                eigthField(context),
              ],
            ),
            heightSpace,
            height5Space,
            continueButton(size),
          ],
        ),
      ),
    );
  }

  contentText() {
    return Text(
      getTranslation(context, 'enter_pin.text'),
      textAlign: TextAlign.center,
      style: semibold16Black33,
    );
  }

  contentReenterText() {
    return Text(
      getTranslation(context, 'reenter_pin.text'),
      textAlign: TextAlign.center,
      style: semibold16Black33,
    );
  }

  welcomeText() {
    return Text(
      getTranslation(context, 'enter_pin.welcome'),
      style: bold22Black,
      textAlign: TextAlign.center,
    );
  }

  pintitle(Size size) {
    return Positioned(
      top: size.height * 0.09,
      left: 0,
      right: 0,
      child: Text(
        getTranslation(context, 'enter_pin.choose_pin'),
        style: bold25White,
        textAlign: TextAlign.center,
      ),
    );
  }

  backArrow(BuildContext context) {
    return Positioned(
      top: 20,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
            icon: const Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  backgroundImage(Size size) {
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

  continueButton(Size size) {
    return GestureDetector(
      onTap: () {

        getUniqueIdentifier();
        String val1='',val2='',val3='',val4='',val5='',val6='',val7='',val8='';
        String Pin ='', VerifyPin='';
        val1 = firstController.text;
        val2= secondController.text;
        val3=thirdController.text;
        val4=fourController.text;
        val5=fifthController.text;
        val6=sixthController.text;
        val7=seventhController.text;
        val8=eightController.text;

        if (val1=='' || val2=='' || val3=='' || val3=='' || val4=='' || val5=='' || val6=='' || val7=='' || val8=='' )
          {
            showErrorMessage('Kindly provide all the pin and verification pin numbers');
            return;
          }

        Pin=val1+val2+val3+val4;
        VerifyPin=val5+val6+val7+val8;

        if (Pin != VerifyPin)
          {
            showErrorMessage('Pin and Pin Verification not matching. Kindly retry');
            return;
          }else
          {
            Timer(const Duration(seconds: 3), () async {

              Map<String, String> requestBody = {
                'MobileNumber': AppMobile,
                'DeviceNumber': deviceCode,
                'Pin': VerifyPin
              };

              try {
                var response = await http.post(
                  Uri.parse(APIPinRegister),
                  body: jsonEncode(requestBody),
                  headers: {'Content-Type': 'application/json'},
                );
                int statusCode = response.statusCode;

                int ResStatus = 0;
                String ResDetails = '';
                String resPKey = '';
                String resSKey = '';

                if (statusCode == 403)
                {
                  showErrorMessage('Error experienced while updating pin details. Kindly retry');
                } else if (statusCode == 200)
                {
                  Map<String, dynamic> jsonResponse = json.decode(response.body);
                  ResStatus = jsonResponse['status'];

                  if (ResStatus == 403) {
                    ResDetails = jsonResponse['detail'];
                    resPKey = jsonResponse['ReturnPKey'];
                    resSKey = jsonResponse['ChildId'];

                    showErrorMessage(ResDetails);

                  }else if (ResStatus == 202) {
                    Navigator.pushNamed(context, '/loginactive');
                    //waitDialog();
                  }
                } else {
                  AppMobile='';
                  showErrorMessage('Unable to proceed. Kindly try again later');
                }

              } catch (error) {
                // Handle network-related errors
                showErrorMessage('Network error during Login: $error');
              }


            });
            //
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
          getTranslation(context, 'enter_pin.continue'),
          style: bold18White,
        ),
      ),
    );
  }

  waitDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: fixPadding * 3, horizontal: fixPadding),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SpinKitFadingCircle(
                color: primaryColor,
                size: 40,
              ),
              heightSpace,
              Text(
                getTranslation(context, 'enter_pin.please_wait'),
                style: bold16Primary,
              )
            ],
          ),
        );
      },
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

  eigthField(BuildContext context) {
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
        //onChanged: (value) {
        //  if (value.length == 1) {
        //    Timer(const Duration(seconds: 3), () {
              //Navigator.pushNamed(context, '/bottomNavigation');
        //    });
            //waitDialog();
        //  }
        //},
        style: semibold20Primary,
        cursorColor: primaryColor,
        controller: eightController,
        keyboardType: TextInputType.number,
        obscureText: true,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  seventhField(BuildContext context) {
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
        controller: seventhController,
        keyboardType: TextInputType.number,
        obscureText: true,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

   sixthField(BuildContext context) {
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
        controller: sixthController,
        keyboardType: TextInputType.number,
        obscureText: true,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  fifthField(BuildContext context) {
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
        controller: fifthController,
        keyboardType: TextInputType.number,
        obscureText: true,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
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
            FocusScope.of(context).nextFocus();
          }
        },
        style: semibold20Primary,
        cursorColor: primaryColor,
        controller: fourController,
        keyboardType: TextInputType.number,
        obscureText: true,
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
        obscureText: true,
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
        obscureText: true,
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
        obscureText: true,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
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

}
