import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:brisk/localization/localization_const.dart';
import 'package:brisk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../constants/datapull.dart';

class LoanApplicationScreen extends StatefulWidget {
  const LoanApplicationScreen({super.key});

  @override
  State<LoanApplicationScreen> createState() => _LoanAppicationState();
}

class _LoanAppicationState extends State<LoanApplicationScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController loanamountController = TextEditingController();
  TextEditingController dailysalesController = TextEditingController();
  TextEditingController dailyexpensesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        shadowColor: blackColor.withOpacity(0.4),
        foregroundColor: black33Color,
        backgroundColor: scaffoldBgColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        titleSpacing: 0,
        title: Text(
          getTranslation(context, 'education_loan.education_loan'),
          style: bold20Black33,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: fixPadding * 2),
        physics: const BouncingScrollPhysics(),
        children: [
          topImage(size),
          descriptionText(),
          dottedline(),
          heightSpace,
          heightSpace,
          phoneTitle(),
          heightSpace,
          loanamountField(),
          heightSpace,
          heightSpace,
          dailysalesField(),
          heightSpace,
          heightSpace,
          dailyexpensesField(),
          heightSpace,
          heightSpace,
          messageTitle(),
          heightSpace,
          messageField(size),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          iamInterestedButton(),
        ],
      ),
    );
  }

  iamInterestedButton() {
    return GestureDetector(
      onTap: () async {

        String? AppStatus;
        String eLoan = loanamountController.text;
        String eSales = dailysalesController.text;
        String eExpenses = dailyexpensesController.text;

        if (eLoan == '')
        {
          showErrorMessage('Please provide your Loan Amount');
          return;
        }

        if (eSales == '')
        {
          showErrorMessage('Please provide your Daily Sales');
          return;
        }

        if (eExpenses == '')
        {
          showErrorMessage('Please provide your Daily Expenses');
          return;
        }

        waitDialog();
        Timer(const Duration(seconds: 3), () async {
          AppStatus = await  DoLoanApplication(returnDetails[0]['AccountID'].toString(),eLoan,eExpenses,eSales);
          Navigator.of(context).pop();

          if(AppStatus=="Error")
          {
            showErrorMessage('Loan Application did not go through! Please try again later.');
          }else {
            //Do the Loan Application Here


            showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(
                    backgroundColor: whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.all(fixPadding * 2),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          getTranslation(
                              context, 'education_loan.education_loan'),
                          style: bold18Primary,
                          textAlign: TextAlign.center,
                        ),
                        heightSpace,
                        Text(
                          getTranslation(context, 'education_loan.thank_you'),
                          style: bold16Black33,
                          textAlign: TextAlign.center,
                        ),
                        const Divider(
                          thickness: 1.5,
                          color: greyD9Color,
                          height: 30,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text(
                              getTranslation(context, 'education_loan.okay'),
                              style: bold18Primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            );
          }


        });


      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(fixPadding * 1.5),
        margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
        decoration: BoxDecoration(
          color: primaryColor,
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslation(context, 'education_loan.interested'),
          style: bold18White,
        ),
      ),
    );
  }

  messageField(Size size) {
    return Container(
      height: size.height * 0.14,
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.25),
            blurRadius: 6,
          )
        ],
      ),
      child: TextField(
        expands: true,
        maxLines: null,
        minLines: null,
        controller: messageController,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText:
          getTranslation(context, 'education_loan.write_your_message'),
          hintStyle: semibold15Grey94,
        ),
      ),
    );
  }

  messageTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Text(
        getTranslation(context, 'education_loan.message'),
        style: bold17Black33,
      ),
    );
  }

  phoneField() {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.25),
            blurRadius: 6,
          )
        ],
      ),
      child: TextField(
        controller: phoneController,
        keyboardType: TextInputType.phone,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText:
          getTranslation(context, 'education_loan.enter_phone_number'),
          hintStyle: semibold15Grey94,
        ),
      ),
    );
  }

  loanamountField() {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.25),
            blurRadius: 6,
          )
        ],
      ),
      child: TextField(
        controller: loanamountController,
        keyboardType: TextInputType.number,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText:
          getTranslation(context, 'education_loan.enter_loanamount'),
          hintStyle: semibold15Grey94,
        ),
      ),
    );
  }


  dailysalesField() {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.25),
            blurRadius: 6,
          )
        ],
      ),
      child: TextField(
        controller: dailysalesController,
        keyboardType: TextInputType.number,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText:
          getTranslation(context, 'education_loan.enter_sales'),
          hintStyle: semibold15Grey94,
        ),
      ),
    );
  }


  dailyexpensesField() {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.25),
            blurRadius: 6,
          )
        ],
      ),
      child: TextField(
        controller: dailyexpensesController,
        keyboardType: TextInputType.number,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText:
          getTranslation(context, 'education_loan.enter_expenses'),
          hintStyle: semibold15Grey94,
        ),
      ),
    );
  }

  phoneTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Text(
        getTranslation(context, "education_loan.enter_loan"),
        style: bold17Black33,
      ),
    );
  }

  dottedline() {
    return DottedBorder(
      dashPattern: const [2, 3],
      padding: EdgeInsets.zero,
      color: grey87Color,
      child: Container(),
    );
  }

  descriptionText() {
    return const Padding(
      padding: EdgeInsets.all(fixPadding * 2),
      child: Text(
        "Our loans are flexible. The loan application process is easy and transparent. Our interest rates are negotiable and very friendly. ",
        style: semibold14Grey87,
      ),
    );
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

  topImage(Size size) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(fixPadding * 2),
      height: size.height * 0.25,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/loan/image1.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: const Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Apply for a loan \neasily and quickly",
          style: bold18Primary,
        ),
      ),
    );
  }
}
