import 'package:brisk/localization/localization_const.dart';
import 'package:brisk/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../theme/theme.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final servicelist = [
    {
      "image": "assets/home/account.png",
      "name": "Account",
      "routeName": const AccountDetailScreen()
    },
    {
      "image": "assets/home/fundTransfer.png",
      "name": "Fund transfer",
      "routeName": const FundTransferScreen(),
    },
    {
      "image": "assets/home/statement.png",
      "name": "Statement",
      "routeName": const StatementScreen(),
    },
    {
      "image": "assets/bottomNavigation/Glyph_ undefined.png",
      "name": "Deposit",
      "routeName": const BottomNavigationScreen(id: 1)
    },
    {
      "image": "assets/bottomNavigation/money-16-regular.png",
      "name": "Loans",
      "routeName": const BottomNavigationScreen(id: 2)
    },
    {
      "image": "assets/services/circum_credit-card-1.png",
      "name": "Cards",
      "routeName": null
    },
    {"image": "assets/home/receipt.png", "name": "Bill pay", "routeName": null},
    {
      "image": "assets/home/scanpay.png",
      "name": "Scan and pay",
      "routeName": null
    },
    {
      "image": "assets/services/emojione-monotone_money-bag.png",
      "name": "Mutual fund",
      "routeName": null
    },
    {
      "image": "assets/services/insuarance.png",
      "name": "Insurance",
      "routeName": null
    },
    {
      "image": "assets/services/prime_shopping-bag.png",
      "name": "Shop & offer",
      "isDetail": false
    },
    {
      "image": "assets/services/clarity_mobile-phone-line.png",
      "name": "Recharge",
      "routeName": null
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        shadowColor: blackColor.withOpacity(0.4),
        backgroundColor: scaffoldBgColor,
        foregroundColor: black33Color,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text(getTranslation(context, 'services.services'),
            style: appBarStyle),
      ),
      body: servicesListContent(size),
    );
  }

  servicesListContent(Size size) {
    return GridView.builder(
      padding: const EdgeInsets.all(fixPadding * 2),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: fixPadding * 2,
        crossAxisSpacing: fixPadding * 2,
        childAspectRatio: size.width / (size.height / 2),
      ),
      itemCount: servicelist.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (servicelist[index]['routeName'] != null) {
              Navigator.push(
                context,
                PageTransition(
                  child: servicelist[index]['routeName'] as Widget,
                  type: PageTransitionType.rightToLeft,
                ),
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
                  servicelist[index]['image'].toString(),
                  height: 25,
                  width: 25,
                  color: primaryColor,
                ),
                height5Space,
                Text(
                  servicelist[index]['name'].toString(),
                  style: bold15Primary,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
