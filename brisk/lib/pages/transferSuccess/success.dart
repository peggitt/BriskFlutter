import 'package:dotted_border/dotted_border.dart';
import 'package:brisk/constants/datapull.dart';
import 'package:brisk/localization/localization_const.dart';
import 'package:brisk/theme/theme.dart';
import 'package:flutter/material.dart';

class TransferSuccessScreen extends StatefulWidget {
  const TransferSuccessScreen({Key? key}) : super(key: key);

  @override
  State<TransferSuccessScreen> createState() => _TransferSuccessScreenState();
}

class _TransferSuccessScreenState extends State<TransferSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
            child: Column(
              children: [
                const Spacer(),
                successDetail(size),
                const Spacer(),
                backToHomeButton(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  backToHomeButton(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/bottomNavigation');
        },
        child: Text(
          getTranslation(context, 'success.back_home'),
          style: bold16Black33,
        ),
      ),
    );
  }

  successDetail(Size size) {
    return Column(
      children: [
        Container(
          height: size.height * 0.13,
          width: size.height * 0.13,
          decoration: const BoxDecoration(
            color: greenColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.done,
            size: 45,
            color: whiteColor,
          ),
        ),
        heightSpace,
        height5Space,
        Text(
          getTranslation(context, 'success.transfer_successfully'),
          style: bold20Black33,
        ),
        Text(
          "5 feb 2022 ${getTranslation(context, 'success.at')} 9.00am",
          style: bold14Grey87,
        ),
        heightSpace,
        heightSpace,
        Container(
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(fixPadding * 1.5),
                child: Row(
                  children: [
                    detailInfoWidget(
                        getTranslation(context, 'success.transferred_to'),
                        TransferAccountName),
                    detailInfoWidget(getTranslation(context, 'success.from'),
                       TransferFromAccount)
                  ],
                ),
              ),
              DottedBorder(
                color: grey94Color,
                dashPattern: const [2, 3],
                padding: EdgeInsets.zero,
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.all(fixPadding * 2),
                child: Row(
                  children: [
                    detailInfoWidget(
                        getTranslation(context, 'success.remark'), TransactionDesc),
                    detailInfoWidget(
                        getTranslation(context, 'success.amount'), TransferAmount),
                    detailInfoWidget(
                        getTranslation(context, 'success.payment_mode'), "Transfer Transaction")
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  detailInfoWidget(String title, String description) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: semibold16Grey94,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            description,
            style: bold14Black33,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
