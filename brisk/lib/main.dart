import 'package:brisk/localization/localization.dart';
import 'package:brisk/localization/localization_const.dart';
import 'package:brisk/pages/accountdetail/loan_application.dart';
import 'package:brisk/pages/accountdetail/loan_balance.dart';
import 'package:brisk/pages/accountdetail/loan_detail.dart';
import 'package:brisk/pages/accountdetail/loan_limit.dart';
import 'package:brisk/pages/accountdetail/loan_statement.dart';
import 'package:brisk/pages/auth/login_active.dart';
import 'package:brisk/pages/bottomNavigationAgent/bottom_navigation_agent.dart';
import 'package:brisk/pages/customers/customers.dart';
import 'package:brisk/pages/groups/groups.dart';
import 'package:brisk/pages/loans/groupcollections.dart';
import 'package:brisk/pages/loans/grouploans.dart';
import 'package:brisk/pages/services/AgentServices.dart';
import 'package:brisk/pages/transferSuccess/successgroups.dart';
import 'package:brisk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:page_transition/page_transition.dart';

import 'package:brisk/pages/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: MaterialApp(
        title: 'Convenient - Banking',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: primaryColor,
          fontFamily: 'NunitoSans',
          scaffoldBackgroundColor: scaffoldBgColor,
        ),
        home: const SplashScreen(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return PageTransition(
                child: const SplashScreen(),
                type: PageTransitionType.fade,
                settings: settings,
              );
            case '/onboarding':
              return PageTransition(
                child: const OnboardingScreen(),
                type: PageTransitionType.fade,
                settings: settings,
              );
            case '/login':
              return PageTransition(
                child: const LoginScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/loginactive':
              return PageTransition(
                child: const LoginActiveScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/register':
              return PageTransition(
                child: const RegisterScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/otp':
              return PageTransition(
                child: const OtpVerification(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/enterpin':
              return PageTransition(
                child: const EnterPinScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/bottomNavigation':
              return PageTransition(
                child: const BottomNavigationScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/bottomNavigationLoanOfficer':
              return PageTransition(
                child: const BottomNavigationAgentScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/home':
              return PageTransition(
                child: const HomeScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/notification':
              return PageTransition(
                child: const NotificationScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/account':
              return PageTransition(
                child: const AccountDetailScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/loandetails':
              return PageTransition(
                child: const LoanDetailScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/loanbalance':
              return PageTransition(
                child: const LoanBalanceScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/loanlimit':
              return PageTransition(
                child: const LoanLimitScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/loanbstatement':
              return PageTransition(
                child: const LoanBStatementScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );

            case '/statement':
              return PageTransition(
                child: const StatementScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/fundTransfer':
              return PageTransition(
                child: const FundTransferScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/success':
              return PageTransition(
                child: const TransferSuccessScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/successgroups':
              return PageTransition(
                child: const TransferSuccessGroupsScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/services':
              return PageTransition(
                child: const ServicesScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/Agentservices':
              return PageTransition(
                child: const AgentServicesScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/groups':
              return PageTransition(
                child: const GroupsScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/customers':
              return PageTransition(
                child: const CustomersScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/grouploans':
              return PageTransition(
                child: const GroupLoansScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/groupcollections':
              return PageTransition(
                child: const GroupCollectionsScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/transaction':
              return PageTransition(
                child: const TransactionScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/addDeposit':
              return PageTransition(
                child: const AddDepositScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/educationLoan':
              return PageTransition(
                child: const EducationLoan(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/loanStatement':
              return PageTransition(
                child: const LoanStatementScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/loanApplication':
              return PageTransition(
                child: const LoanApplicationScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/editProfile':
              return PageTransition(
                child: const EditProfile(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/changepin':
              return PageTransition(
                child: const ChangePinScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/languages':
              return PageTransition(
                child: const LanguagesScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/privacyPolicy':
              return PageTransition(
                child: const PrivacyPolicyScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/termsAndCondition':
              return PageTransition(
                child: const TermsAndConditionScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );
            case '/customerSupport':
              return PageTransition(
                child: const CustomerSupportScreen(),
                type: PageTransitionType.rightToLeft,
                settings: settings,
              );

            default:
              return null;
          }
        },
        locale: _locale,
        supportedLocales: const [
          Locale('en'),
          Locale('hi'),
          Locale('id'),
          Locale('zh'),
          Locale('ar'),
        ],
        localizationsDelegates: [
          DemoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale?.languageCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}
