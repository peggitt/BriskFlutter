import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:brisk/localization/localization_const.dart';
import 'package:flutter/material.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import '../../theme/theme.dart';

import 'package:device_info/device_info.dart';
import '../../constants/constants.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController accountController = TextEditingController();
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
            children: [
              backgroundImageBox(size),
              backButton(context),
              register(size),
              registerDetails(size, context)
            ],
          ),
        ),
      ),
    );
  }

  registerDetails(Size size, BuildContext context) {
    return Positioned(
      top: size.height * 0.16,
      left: 0,
      right: 0,
      child: Container(
        width: double.maxFinite,
        height: size.height * 0.63,
        padding: const EdgeInsets.symmetric(vertical: fixPadding),
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
          padding: EdgeInsets.only(
              left: fixPadding * 2,
              right: fixPadding * 2,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          children: [
            image(size),
            heightSpace,
            nameField(context),
            heightSpace,
            heightSpace,
            phoneField(context),
            heightSpace,
            heightSpace,
            emailField(context),
            heightSpace,
            heightSpace,
            heightSpace,
            height5Space,
            registerButton(size),
            heightSpace,
            height5Space,
          ],
        ),
      ),
    );
  }

  backButton(BuildContext context) {
    return Positioned(
      top: 20,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
        icon: const Icon(
          Icons.arrow_back,
          color: whiteColor,
        ),
      ),
    );
  }

  register(Size size) {
    return Positioned(
      top: size.height * 0.09,
      left: 0,
      right: 0,
      child: Text(
        getTranslation(context, 'register.register'),
        style: bold25White,
        textAlign: TextAlign.center,
      ),
    );
  }

  title() {
    return const Text(
      "BRISK",
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

  registerButton(Size size) {
    return GestureDetector(
      onTap: () async {
        getUniqueIdentifier();

        String eAccountName = nameController.text;
        String eAccountNumber = accountController.text;
        String eEmail = emailController.text;

        if (eAccountName == '')
          {
            showErrorMessage('Please provide your Account Name');
            return;
          }

        if (eAccountNumber == '')
        {
          showErrorMessage('Please provide your ID Number');
          return;
        }

        if (eEmail == '')
        {
          showErrorMessage('Please provide your Email Address');
          return;
        }

        if (EmailValidator.validate(eEmail) == false)
        {
          showErrorMessage('Please provide a Valid Email Address');
          return;
        }

        Map<String, String> requestBody = {
          'MobileNumber': AppMobile,
          'DeviceNumber': deviceCode,
          'AccountName': eAccountName,
          'AccountNumber': eAccountNumber,
          'EmailAddress': eEmail
        };

        try {
          var response = await http.post(
            Uri.parse(APIRegisterBrisk),
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
            showErrorMessage('Please provide the sign up details');
          } else if (statusCode == 200)
          {
            Map<String, dynamic> jsonResponse = json.decode(response.body);
            ResStatus = jsonResponse['status'];

            if (ResStatus == 403) {
              ResDetails = jsonResponse['detail'];
              resPKey = jsonResponse['ReturnPKey'];
              resSKey = jsonResponse['ChildId'];
              if (resSKey == 'Existing')
                {
                  Navigator.pushNamed(context, '/enterpin');
                }else {
                showErrorMessage(ResDetails);
              }
            }else if (ResStatus == 202) {
              Navigator.pushNamed(context, '/enterpin');
            }
          } else {
            AppMobile='';
            showErrorMessage('Unable to proceed. Kindly try again later');
          }

        } catch (error) {
          // Handle network-related errors
          showErrorMessage('Network error during Login: $error');
        }
        //Extract the details entered and push to the database

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
          getTranslation(context, 'register.register'),
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

  phoneField(BuildContext context) {
    return Container(
      width: double.maxFinite,
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
        child: TextField(
          controller: accountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: getTranslation(context, 'register.enter_id_number'),
            hintStyle: semibold16Grey94,
            prefixIcon: const Icon(
              Icons.account_balance,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  nameField(BuildContext context) {
    return Container(
      width: double.maxFinite,
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
        child: TextField(
          controller: nameController,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: getTranslation(context, 'register.enter_your_name'),
            hintStyle: semibold16Grey94,
            prefixIcon: const Icon(
              Icons.person_outline,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  emailField(BuildContext context) {
    return Container(
      width: double.maxFinite,
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
        child: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: getTranslation(context, 'register.enter_your_email'),
            hintStyle: semibold16Grey94,
            prefixIcon: const Icon(
              Icons.email_outlined,
              size: 20,
            ),
          ),
        ),
      ),
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


  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 5),
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
          title: const Text('Alert..'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
