import 'package:dotted_border/dotted_border.dart';
import 'package:brisk/constants/datapull.dart';
import 'package:brisk/localization/localization_const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/theme.dart';
import '../../widget/column_builder.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({super.key});

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  String? accountType;

  DateTime firstDate = DateTime.now().subtract(const Duration(days: 1));

  DateTime secondDate = DateTime.now();

  final bankAccount = [
    {"name": detailsAccountId, "id": 0},
  ];

  String transactionImage = "assets/home/fundTransfer.png";

  @override
  void initState() {
    setState(() {
      accountType = detailsAccountId;
    });
    super.initState();
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
            returnAccountStatementDetails=[];
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text(
          getTranslation(context, 'statement.statement'),
          style: appBarStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.file_download_outlined,
              color: primaryColor,
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: fixPadding * 2),
        physics: const BouncingScrollPhysics(),
        children: [
          //statementDetail(context),
          heightSpace,
          heightSpace,
          dottedBorder(),
          heightSpace,
          heightSpace,
          selectDate(context),
          heightSpace,
          heightSpace,
          dottedBorder(),
          heightSpace,
          heightSpace,
          transactionTitle(),
          transactionResultList(),
        ],
      ),
    );
  }

  void refreshContainer() {
    setState(() {});
  }

  transactionResultList() {
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
                      FormatDateData(returnAccountStatementDetails[index]['TrxDate'].toString()),
                      style: bold15Black33,
                    ),
                    heightBox(3.0),
                    Text(
                      returnAccountStatementDetails[index]['Description'].toString(),
                      style: bold12Grey94,
                    )
                  ],
                ),
              ),
              returnAccountStatementDetails[index]['TrxType'] == '01'
                  ? Text(
                "${returnAccountStatementDetails[index]['localamount']}",
                      style: bold15Red,
                    )
                  : Text(
                "+${returnAccountStatementDetails[index]['localamount']}",
                      style: bold15Green,
                    )
            ],
          ),
        );
      },
      itemCount: returnAccountStatementDetails.length,
    );
  }

  transactionTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Text(
        getTranslation(context, 'statement.transaction_result'),
        style: bold16Black33,
      ),
    );
  }

  selectDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslation(context, 'statement.select_date'),
            style: bold16Black33,
          ),
          heightSpace,
          Row(
            children: [
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                      primary: primaryColor)),
                              child: child!);
                        });

                    if (pickedDate != null) {
                      setState(() {
                        firstDate = pickedDate;
                      });
                    }
                  },
                  child: Container(
                    height: 45,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: blackColor.withOpacity(0.25),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.date_range_outlined,
                          size: 20,
                          color: primaryColor,
                        ),
                        width5Space,
                        Expanded(
                          child: Text(
                            " ${DateFormat('dd MMM, yyyy', Localizations.localeOf(context).toString()).format(firstDate)}",
                            style: semibold15Black,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              widthSpace,
              widthSpace,
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                      primary: primaryColor)),
                              child: child!);
                        });

                    if (pickedDate != null) {
                      setState(() {
                        secondDate = pickedDate;
                      });
                    }
                  },
                  child: Container(
                    height: 45,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: blackColor.withOpacity(0.25),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.date_range_outlined,
                          size: 20,
                          color: primaryColor,
                        ),
                        widthSpace,
                        Expanded(
                          child: Text(
                            DateFormat('dd MMM, yyyy',
                                    Localizations.localeOf(context).toString())
                                .format(secondDate),
                            style: semibold15Black,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              widthSpace,
              widthSpace,
              Expanded(
                flex: 1,
                child: GestureDetector(
                onTap: () async {
                  //print(firstDate.toString()+' '+secondDate.toString());
                  returnAccountStatementDetails=[];
                  await GetAccountStatementDetails(detailsAccountId,firstDate.toString(),secondDate.toString());
                  refreshContainer();
                },
                child: Container(
                  height: 45,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: FittedBox(
                    child: Text(
                      getTranslation(context, 'statement.go'),
                      style: bold16White,
                    ),
                  ),
                ),
              ),
              )
            ],
          ),
        ],
      ),
    );
  }

  dottedBorder() {
    return DottedBorder(
      padding: EdgeInsets.zero,
      dashPattern: const [1.5, 4],
      color: grey87Color,
      child: Container(),
    );
  }

  statementDetail(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      padding: const EdgeInsets.symmetric(
          vertical: fixPadding, horizontal: fixPadding * 1.5),
      decoration: BoxDecoration(
        color: const Color(0xFFE5D1D8),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    bankaccountTypeSheet(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        detailsAccountName,
                        style: bold14Grey87,
                      ),
                      widthSpace,
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: grey87Color,
                      )
                    ],
                  ),
                ),
                height5Space,
                Text(
                  detailsAccountId,
                  style: semibold16Black33,
                )
              ],
            ),
          ),
          widthSpace,
          Column(
            children: [
              Text(
                getTranslation(context, 'account_detail.total_balance'),
                style: bold14Grey87,
              ),
              height5Space,
              Text(
                detailsAccountIdBalance,
                style: bold20Primary,
              )
            ],
          )
        ],
      ),
    );
  }

  bankaccountTypeSheet(BuildContext context) {
    return showModalBottomSheet(
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
                          accountType = detailsAccountId;
                        });
                        Navigator.pop(context);
                      },
                      title: Text(
                        detailsAccountId,
                        style: bold16Black33,
                      ),
                    ),
                    bankAccount.length - 1 == index
                        ? const SizedBox()
                        : Container(
                            color: greyD9Color,
                            height: 1,
                            width: double.maxFinite,
                          )
                  ],
                );
              },
              itemCount: bankAccount.length),
        );
      },
    );
  }

  String FormatDateData(PassDate)
  {
    DateTime dateTime = DateTime.parse(PassDate);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }
}
