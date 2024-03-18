import 'package:brisk/localization/localization_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/constants.dart';
import '../../constants/datapull.dart';
import '../../theme/theme.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/deposite/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: primaryColor.withOpacity(0.5),
          ),
        ),
        title: Text(
          getTranslation(context, 'account.account'),
          style: appBarStyle,
        ),
      ),
      body: Column(
        children: [
          userInfo(size, context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: fixPadding),
              physics: const BouncingScrollPhysics(),
              children: [
                pinTileWidget(context),
                tileWidget(CupertinoIcons.globe,
                    getTranslation(context, 'account.language'), () {
                  Navigator.pushNamed(context, '/languages');
                }),
                tileWidget(Icons.privacy_tip_outlined,
                    getTranslation(context, 'account.privacy_policy'), () {
                  Navigator.pushNamed(context, '/privacyPolicy');
                }),
                tileWidget(CupertinoIcons.doc_plaintext,
                    getTranslation(context, 'account.terms_condition'), () {
                  Navigator.pushNamed(context, '/termsAndCondition');
                }),
                tileWidget(Icons.headset_mic_outlined,
                    getTranslation(context, 'account.customer_support'), () {
                  Navigator.pushNamed(context, '/customerSupport');
                }),
                tileWidget(
                  Icons.logout,
                  getTranslation(context, 'account.logout'),
                  () {
                    logoutDialog(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  logoutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: const EdgeInsets.all(fixPadding * 2.0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              getTranslation(context, 'account.logout'),
              style: bold18Primary,
              textAlign: TextAlign.center,
            ),
            heightSpace,
            heightSpace,
            Text(
              getTranslation(context, 'account.logout_text'),
              style: bold16Black33,
              textAlign: TextAlign.center,
            ),
            const Divider(
              height: 30,
              color: greyD9Color,
              thickness: 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                    child: Text(
                      getTranslation(context, 'account.cancel'),
                      style: bold18Grey87,
                    ),
                  ),
                ),
                width5Space,
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                    child: Text(
                      getTranslation(context, 'account.yes'),
                      style: bold18Primary,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  tileWidget(IconData icon, String title, Function() onTap) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      leading: Container(
        height: 35,
        width: 35,
        decoration: const BoxDecoration(
          color: Color(0xFfDFDFDF),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: primaryColor,
          size: 18,
        ),
      ),
      minLeadingWidth: 0,
      title: Text(
        title,
        style: semibold15Black,
      ),
    );
  }

  pinTileWidget(context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, '/changepin');
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      leading: Container(
        height: 35,
        width: 35,
        decoration: const BoxDecoration(
          color: Color(0xFfDFDFDF),
          shape: BoxShape.circle,
        ),
        child: Transform.rotate(
          angle: 1,
          child: const Icon(
            Icons.push_pin_outlined,
            color: primaryColor,
            size: 18,
          ),
        ),
      ),
      minLeadingWidth: 0,
      title: Text(
        getTranslation(context, 'account.change_pin'),
        style: semibold15Black,
      ),
    );
  }

  userInfo(Size size, BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
          vertical: fixPadding * 1.5, horizontal: fixPadding * 2),
      decoration: BoxDecoration(
        color: const Color(0xFFECECEC),
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
            height: size.height * 0.08,
            width: size.height * 0.08,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  "assets/profile/marker.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          widthSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detailsAccountName,
                  style: bold16Black33,
                ),
                heightBox(3.0),
                Text(
                  AppMobile,
                  style: semibold14Grey94,
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
