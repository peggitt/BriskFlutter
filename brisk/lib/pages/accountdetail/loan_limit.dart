import 'package:brisk/localization/localization_const.dart';
import 'package:brisk/widget/column_builder.dart';
import 'package:flutter/material.dart';

import '../../constants/datapull.dart';
import '../../theme/theme.dart';

class LoanLimitScreen extends StatefulWidget {
  const LoanLimitScreen({Key? key}) : super(key: key);

  @override
  State<LoanLimitScreen> createState() => _LoanLimitScreenState();
}

class _LoanLimitScreenState extends State<LoanLimitScreen> {
  String? accountType;
  int selIndex=0;

  @override
  void initState() {
    setState(() {
      if(returnDetails.isNotEmpty) {
        accountType = returnDetails[0]['AccountID'].toString();
        detailsAccountId = returnDetails[0]['AccountID'].toString();
        detailsAccountIdBalance = returnDetails[0]['Clearbalance'].toString();
        selIndex=0;
        initializeIdentifier();
      }else
      {
        accountType = 'NA';
      }
    });
    super.initState();
  }

  Future<void> initializeIdentifier() async {
    setState(() async {
      // Trigger a rebuild to update the UI with the identifier value
      await GetLoanLimit(returnDetails[0]['AccountID'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          getTranslation(context, 'account_detail.balance'),
          style: appBarStyle,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2),
        children: [
          bankAccountType(context),
          heightSpace,
          heightSpace,
          totalbalanceinfo(),
          heightSpace,
          heightSpace,
          accountDetailTitle(),
          heightSpace,
          detailTile(
              getTranslation(context, 'account_detail.limit'), returnLoanLimit[0]['limit'].toString()),

          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          //viewStatementButton(context)
        ],
      ),
    );
  }

  viewStatementButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/statement');
      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: fixPadding * 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
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
          getTranslation(context, 'account_detail.view_statement'),
          style: bold18White,
        ),
      ),
    );
  }

  detailTile(String title, String detail) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: semibold15Grey94,
          ),
        ),
        widthSpace,
        Text(
          detail,
          style: semibold15Black33,
        )
      ],
    );
  }

  accountDetailTitle() {
    return Text(
      getTranslation(context, 'account_detail.account_details'),
      style: bold18Black33,
    );
  }

  totalbalanceinfo() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(fixPadding * 1.5),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.25),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  returnDetails[selIndex]['AccountName'].toString(),
                  style: bold16Black33,
                ),
                heightSpace,
                Text(
                  getTranslation(context, 'account_detail.product_name'),
                  style: semibold14Grey94,
                ),
                Text(
                  returnAccountDetails[0]['Description'].toString(),
                  style: semibold15Black33,
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getTranslation(context, 'account_detail.clear_balance'),
                style: bold14Grey94,
              ),
              height5Space,
              Text(
                returnDetails[selIndex]['Clearbalance'],
                style: bold20Primary,
              )
            ],
          ),
        ],
      ),
    );
  }

  bankAccountType(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: fixPadding),
                child: ColumnBuilder(
                    mainAxisSize: MainAxisSize.min,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            onTap: () {
                              setState(() {
                                accountType =
                                    returnDetails[index]['AccountID'].toString();
                                GetAccountDetails(accountType);
                              });
                              Navigator.pop(context);
                            },
                            title: Text(
                              returnDetails[index]['AccountName'].toString(),
                              style: bold16Black33,
                            ),
                          ),
                          returnDetails.length - 1 == index
                              ? const SizedBox()
                              : Container(
                            color: greyD9Color,
                            height: 1,
                            width: double.maxFinite,
                          )
                        ],
                      );
                    },
                    itemCount: returnDetails.length),
              );
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: fixPadding / 1.5,
            horizontal: fixPadding * 1.5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: whiteColor,
            border: Border.all(color: primaryColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                accountType.toString(),
                style: bold16Primary,
              ),
              widthSpace,
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
