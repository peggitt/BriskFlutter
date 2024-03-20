import 'dart:convert';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:brisk/localization/localization_const.dart';
import 'package:brisk/theme/theme.dart';
import 'package:brisk/widget/column_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../constants/datapull.dart';
import '../../theme/theme.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    initializeIdentifier();
  }

  Future<void> initializeIdentifier() async {
    setState(() {
      // Trigger a rebuild to update the UI with the identifier value
      GetAccountDetails(returnDetails[0]['AccountID'].toString());
    });
  }


  String transactionImage = "assets/home/fundTransfer.png";
  final servicelist = [
    {
      "image": "assets/home/account.png",
      "name": "Account",
      "isDetail": true,
      "routeName": "/account"
    },
    {
      "image": "assets/home/fundTransfer.png",
      "name": "Loan Details",
      "isDetail": true,
      "routeName": "/loandetails"
    },
    {
      "image": "assets/home/statement.png",
      "name": "Loan Balance",
      "isDetail": true,
      "routeName": "/loanbalance"
    },
    {"image": "assets/home/receipt.png", "name": "Loan Limit", "isDetail": true,"routeName": "/loanlimit"},
    {
      "image": "assets/home/scanpay.png",
      "name": "Loan Statement",
      "isDetail": true,
      "routeName": "/loanbstatement"
    },
    {
      "image": "assets/home/receipt.png",
      "name": "Loan Application",
      "isDetail": true,
      "routeName": "/loanApplication"
    },

    {"image": "assets/home/receipt.png", "name": "Bill pay", "isDetail": false},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          topBox(size),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: fixPadding * 2),
              physics: const BouncingScrollPhysics(),
              children: [
                serviceTitle(),
                serviceList(size),
                heightSpace,
                latestTtile(),
                latestTransectionList(),
              ],
            ),
          )
        ],
      ),
    );
  }

  latestTransectionList() {
    return ColumnBuilder(
      itemBuilder: (context, index) {
        return Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(
              vertical: fixPadding, horizontal: fixPadding * 2),
          padding: const EdgeInsets.all(fixPadding * 1.5),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.25),
                blurRadius: 6,
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 38,
                width: 38,
                padding: const EdgeInsets.all(fixPadding / 1.2),
                decoration: const BoxDecoration(
                  color: Color(0xFFEDEBEB),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  transactionImage,
                ),
              ),
              widthSpace,
              width5Space,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Loan Details",
                      style: bold15Black33,
                    ),
                    heightBox(3.0),
                    Text(
                      "Loan Balance",
                      style: bold12Grey94,
                    )
                  ],
                ),
              ),
              statementData[index]['TrxType'] == '01'
                  ? Text(
                      "${statementData[index]['localamount']}",
                      style: bold15Red,
                    )
                  : Text(
                      "+${statementData[index]['localamount']}",
                      style: bold15Green,
                    )
            ],
          ),
        );
      },
      itemCount: statementData.length,
    );
  }

  latestTtile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              getTranslation(context, 'home.latest_statement'),
              style: bold18Black33,
            ),
          ),

        ],
      ),
    );
  }

  serviceList(Size size) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
          left: fixPadding * 2,
          right: fixPadding * 2,
          bottom: fixPadding,
          top: fixPadding),
      crossAxisCount: 3,
      childAspectRatio: (size.width) / (size.height / 2),
      shrinkWrap: true,
      mainAxisSpacing: fixPadding * 2,
      crossAxisSpacing: fixPadding * 2,
      children: [
        for (int i = 0; i < servicelist.length; i++)
          GestureDetector(
            onTap: () {

              if (servicelist[i]['isDetail'] == true) {
                Navigator.pushNamed(
                  context,
                  servicelist[i]['routeName'].toString(),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(fixPadding),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: blackColor.withOpacity(0.25),
                    blurRadius: 6,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    servicelist[i]['image'].toString(),
                    height: 24,
                    width: 24,
                    color: primaryColor,
                  ),
                  height5Space,
                  Text(servicelist[i]['name'].toString(),
                      style: bold15Primary,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis)
                ],
              ),
            ),
          ),
      ],
    );
  }

  serviceTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Text(
        getTranslation(context, 'home.services'),
        style: bold18Black33,
      ),
    );
  }

  topBox(Size size) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/bg.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.5),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightSpace,
              topTitle(),
              heightSpace,
              height5Space,
              accountTypeList(size),
              heightSpace,
              height5Space,
            ],
          ),
        ),
      ),
    );
  }

  topTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/splash/mdi_star-three-points-outline.png",
                height: 28,
                width: 28,
                color: whiteColor,
              ),
              widthSpace,
              const Text(
                "BRISK",
                style: interSemibold20White,
              )
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/notification');
            },
            child: const SizedBox(
              height: 26,
              width: 26,
              child: Icon(
                CupertinoIcons.bell,
                color: whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  accountTypeList(Size size)  {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: fixPadding),
      child: Row(
        children: List.generate(
          returnDetails.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding),
            child: BlurryContainer(
              blur: 8.0,
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: size.width * 0.8,
                padding: const EdgeInsets.symmetric(
                    horizontal: fixPadding * 1.5, vertical: fixPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFDEB16C).withOpacity(0.15),
                  border: Border.all(
                    color: const Color(0xFFEC98B3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      overflow: TextOverflow.ellipsis,
                      TextSpan(
                        text: getTranslation(context, 'home.loan_balance'),
                        style: bold18GreyD6,
                        children: [
                          const TextSpan(text: " : "),
                          TextSpan(
                            text: returnDetails[index]['Clearbalance'],
                            style: bold22GreyD6,
                          )
                        ],
                      ),
                    ),
                    heightSpace,
                    height5Space,
                    Text(
                      returnDetails[index]['AccountName'].toString(),
                      style: semibold14EE,
                    ),
                    Text(
                      returnDetails[index]['AccountID'].toString(),
                      style: bold14EE,
                    )
                  ],
                ),
              ),
            ),
          ),
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

  String FormatDateData(PassDate)
  {
    DateTime dateTime = DateTime.parse(PassDate);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }

  String FormatValue(number)
  {
    NumberFormat numberFormat = NumberFormat('#,##0.00');
    String formattedNumber = numberFormat.format(number);
    return formattedNumber;
  }



}
