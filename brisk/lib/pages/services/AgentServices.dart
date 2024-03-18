import 'package:brisk/localization/localization_const.dart';
import 'package:brisk/pages/loans/groupcollections.dart';
import 'package:brisk/pages/screens.dart';
import 'package:brisk/pages/survey/survey.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../theme/theme.dart';
import '../customers/customers.dart';
import '../groups/groups.dart';
import '../loans/grouploans.dart';

class AgentServicesScreen extends StatefulWidget {
  const AgentServicesScreen({Key? key}) : super(key: key);

  @override
  State<AgentServicesScreen> createState() => _AgentServicesScreenState();
}

class _AgentServicesScreenState extends State<AgentServicesScreen> {
  final servicelist = [
    {
      "image": "assets/home/account.png",
      "name": "Account",
      "routeName": const AccountDetailScreen(),
    },
    {
      "image": "assets/home/statement.png",
      "name": "Statement",
      "routeName": const StatementScreen(),
    },
    {
      "image": "assets/home/person.png",
      "name": "Customers",
      "isDetail": true,
      "routeName": const CustomersScreen(),
    },
    {
      "image": "assets/home/receipt.png",
      "name": "Groups",
      "isDetail": true,
      "routeName": const GroupsScreen(),
    },
    {
      "image": "assets/home/home-database.png",
      "name": "Loans",
      "isDetail": true,
      "routeName": const GroupLoansScreen(),
    },
    {
      "image": "assets/home/marker.png",
      "name": "Collections",
      "isDetail": true,
      "routeName": const GroupCollectionsScreen(),
    },
    {
      "image": "assets/home/scanpay.png",
      "name": "Survey",
      "isDetail": true,
      "routeName": const SurveyScreen(),
    }

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
