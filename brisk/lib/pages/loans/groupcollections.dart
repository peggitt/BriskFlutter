import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:brisk/localization/localization_const.dart';
import 'package:brisk/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/constants.dart';
import '../../constants/datapull.dart';
import '../../theme/theme.dart';
import 'package:http/http.dart' as http;

class GroupCollectionsScreen extends StatefulWidget {
  const GroupCollectionsScreen({Key? key}) : super(key: key);

  @override
  State<GroupCollectionsScreen> createState() => _GroupCollectionsScreenState();
}

class _GroupCollectionsScreenState extends State<GroupCollectionsScreen> {
  final tabbarlist = [
    translation('collections.collect_now'),
    translation('collections.active_laons')
  ];

  int selectedPayMethod = 0;
  int selectedAccountNumber = 0;
  int selectedIBANAccount = 0;
  int selectedimpsAccount = 0;
  String groupId='';
  String groupGl='';

  late List<dynamic> returnMembers=[];
  late List<dynamic> returnLoans=[];

  final bankNameList = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  final currentLoans = [
    {
      "icon": "assets/loan/home-database.png",
      "name": "Home loan",
      "accountNo": "1234 4567 8956 1222",
      "amount": 20000.00,
      "period": "24 month",
      "Rate": "13%",
      "EMI": 1000.00,
    },
    {
      "icon": "assets/loan/car-outline.png",
      "name": "Car loan",
      "accountNo": "1234 4567 8956 1222",
      "amount": 10000.00,
      "period": "12 month",
      "Rate": "10%",
      "EMI": 1000.00,
    },
  ];

  TextEditingController groupIdController = TextEditingController();
  TextEditingController groupNameController = TextEditingController();
  TextEditingController schemeNameController = TextEditingController();
  TextEditingController registrationDateController = TextEditingController();
  TextEditingController groupOfficerController = TextEditingController();
  TextEditingController membersController = TextEditingController();

  TextEditingController memberIDNoController = TextEditingController();
  TextEditingController newMemberIdController = TextEditingController();

  TextEditingController newGroupName = TextEditingController();
  TextEditingController newGroupDescription = TextEditingController();
  TextEditingController newGroupMeetingDate = TextEditingController();
  TextEditingController impsBankNameController = TextEditingController();

  String transactionImage = "assets/home/person.png";

  @override
  void initState() {
    groupIdController.text ='';
    newMemberIdController.text='';
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
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text(
          getTranslation(context, 'collections.collections_group'),
          style: appBarStyle,
        ),
      ),
      body: Column(
        children: [
          heightSpace,
          heightSpace,
          tabBar(),
          heightSpace,
          if (selectedPayMethod == 1) GroupLoans(context),
          if (selectedPayMethod == 0) GroupLoanApplication(context)
        ],
      ),
    );
  }

  impsBankList(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(
            vertical: fixPadding / 2,
          ),
          decoration: const BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(fixPadding * 2),
            ),
          ),
          child: ColumnBuilder(
            mainAxisSize: MainAxisSize.min,
            itemBuilder: (context, index) {
              return banknamelist(index, context, () {
                setState(() {
                  impsBankNameController.text = bankNameList[index].toString();
                });
                Navigator.pop(context);
              });
            },
            itemCount: bankNameList.length,
          ),
        );
      },
    );
  }


  GroupLoans(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2, vertical: fixPadding),
        physics: const BouncingScrollPhysics(),
        children: [
          title(getTranslation(context, 'grouploans.current_loans')),
          heightSpace,
          currentLoansListContent(),
        ],
      ),
    );
  }

  iBANBankList(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(
            vertical: fixPadding / 2,
          ),
          decoration: const BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(fixPadding * 2),
            ),
          ),
          child: ColumnBuilder(
            mainAxisSize: MainAxisSize.min,
            itemBuilder: (context, index) {
              return banknamelist(index, context, () {
                setState(() {
                  newGroupMeetingDate.text = bankNameList[index].toString();
                });
                Navigator.pop(context);
              });
            },
            itemCount: bankNameList.length,
          ),
        );
      },
    );
  }

  GroupLoanApplication(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2, vertical: fixPadding),
        physics: const BouncingScrollPhysics(),
        children: [
          title(getTranslation(context, 'groups.group_id')),
          heightSpace,
          textField(
            TextField(
              controller: groupIdController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:
                getTranslation(context, 'groups.group_details'),
                hintStyle: semibold15Grey94,
              ),
            ),
          ),
          SizedBox(width: 8.0), // Adjust the spacing between the TextField and the button
          ElevatedButton(
            onPressed: () async{

              returnAccountStatementDetails=[];
              groupId=groupIdController.text;

              if (groupId == '')
              {
                showErrorMessage('Please provide the Group Number!');
                return;
              }else
              {
                final String token = APIauthToken;

                final Map<String, String> headers = {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token',
                };
                //Call Core to Populate the data Below
                Map<String, String> requestBody = {
                  'MobileNumber': AppMobile,
                  'DeviceNumber': deviceCode,
                  'GroupId': groupId
                };
                print('Calling Group Details..');
                try {
                  var response = await http.post(
                    Uri.parse(APIGroupDetails),
                    body: jsonEncode(requestBody),
                    headers: headers,
                  );
                  Map<String, dynamic> jsonResponse = json.decode(
                      response.body);
                  int statusCode = response.statusCode;

                  if (statusCode == 403) {
                    showErrorMessage('Invalid Session Details.');
                  } else if (statusCode == 404) {
                    setState(() {
                      returnLoans=[];
                      groupNameController.text  =  '';
                      schemeNameController.text = '';
                      registrationDateController.text = '';
                      groupOfficerController.text = '';
                      membersController.text = '';
                    });
                    showErrorMessage('Group Details Not Found.');
                  } else if (statusCode == 500) {
                    showErrorMessage('An error occurred. Please contact the System Admin');
                  }else
                  {
                    late List<dynamic> returnDetails=[];
                    returnMembers=[];
                    returnLoans=[];
                    returnDetails = jsonResponse['returnDetails'];
                    returnMembers = jsonResponse['returnMembers'];
                    PopulateGroupLoans(groupId);
                    postGroupId = groupId;
                    setState(() {
                      groupNameController.text  = returnDetails[0]['GroupName']?.toString() ?? 'Null';
                      schemeNameController.text = returnDetails[0]['SchemeName']?.toString() ?? 'Null';
                      registrationDateController.text = returnDetails[0]['RegistrationDate']?.toString() ?? 'Null';
                      groupOfficerController.text = returnDetails[0]['GroupOfficer']?.toString() ?? 'Null';
                      membersController.text = returnDetails[0]['Members']?.toString() ?? 'Null';
                      groupId = returnDetails[0]['PostingGl']?.toString() ?? 'Null';
                      postGroupGl = returnDetails[0]['PostingGl']?.toString() ?? 'Null';
                      showInfoMessage('Group Details Loaded.');
                    });

                  }
                }catch (error) {
                  // Handle network-related errors
                  Navigator.of(context).pop();
                  showErrorMessage('Network error during Login: $error');
                }

              }
            },
            child: Text('Search'),
          ),
          heightSpace,
          heightSpace,
          title(getTranslation(context, 'groups.group_details')),
          heightSpace,
          textFieldWidget(
              getTranslation(context, 'groups.group_name'),
              groupNameController,
              TextInputType.name),
          heightSpace,
          height5Space,
          height5Space,
          textFieldWidget(
              getTranslation(
                  context, 'groups.group_scheme'),
              schemeNameController,
              TextInputType.name),
          heightSpace,
          height5Space,
          textFieldWidget(getTranslation(context, 'groups.group_regdate'),
              registrationDateController, TextInputType.name),
          heightSpace,
          height5Space,
          textFieldWidget(
              getTranslation(context, 'groups.group_officer'),
              groupOfficerController,
              TextInputType.name),
          heightSpace,
          heightSpace,
          textFieldWidget(
              getTranslation(context, 'groups.group_members'),
              membersController,
              TextInputType.number),
          heightSpace,
          heightSpace,
          transactionResultList(),
          heightSpace,
          heightSpace,
          newMemberButton()
        ],
      ),
    );
  }

  membersTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Text(
        getTranslation(context, 'groups.group_memberlist'),
        style: bold16Black33,
      ),
    );
  }

  addmembersTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Text(
        getTranslation(context, 'groups.group_searchMembers'),
        style: bold16Black33,
      ),
    );
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
                      returnMembers[index]['CustomerId'].toString(),
                      style: bold15Black33,
                    ),
                    heightBox(3.0),
                    TextFormField(
                      initialValue: returnMembers[index]['LoanCollectionAmount'].toString(),
                      style: bold12Grey94,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Loan Repayment',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        // Handle changes to the text field
                        returnMembers[index]['LoanCollectionAmount'] = value;
                      },
                    ),
                    heightBox(3.0),
                    TextFormField(
                      initialValue: returnMembers[index]['SavingsCollection'].toString(),
                      style: bold12Grey94,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Savings Amount',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        // Handle changes to the text field
                        returnMembers[index]['SavingsCollection'] = value;
                      },
                    ),
                  ],
                ),
              ),
              Text(
                '${returnMembers[index]['Name1']} ${returnMembers[index]['Name2']}',
                style: bold15Green,
              )
            ],
          ),
        );
      },
      itemCount: returnMembers.length,
    );
  }

  textFieldWidget(String hintText, TextEditingController controller,
      TextInputType keyboardType) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(color: blackColor.withOpacity(0.25), blurRadius: 6)
        ],
      ),
      child: TextField(
        enabled: false,
        keyboardType: keyboardType,
        cursorColor: primaryColor,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: semibold15Grey94,
        ),
      ),
    );
  }


  textFieldWidgetEditable(String hintText, TextEditingController controller,
      TextInputType keyboardType) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(color: blackColor.withOpacity(0.25), blurRadius: 6)
        ],
      ),
      child: TextField(
        keyboardType: keyboardType,
        cursorColor: primaryColor,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: semibold15Grey94,
        ),
      ),
    );
  }

  title(String text) {
    return Text(
      text,
      style: bold17Black33,
    );
  }

  banknamelist(int index, BuildContext context, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              bankNameList[index].toString(),
              style: bold16Black33,
            ),
          ),
          bankNameList.length - 1 == index
              ? const SizedBox.shrink()
              : Container(
            width: double.maxFinite,
            height: 1,
            color: greyD9Color,
          ),
        ],
      ),
    );
  }

  dialogContent(StateSetter state, int index, BuildContext context,
      Function() onTap, int selected) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: fixPadding,
          horizontal: fixPadding * 2,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: fixPadding,
          horizontal: fixPadding * 2,
        ),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    returnDetails[index]['AccountName'].toString(),
                    style: bold16Black33,
                  ),
                  height5Space,
                  Text(
                    returnDetails[index]['AccountID'].toString(),
                    style: semibold16Black33,
                  )
                ],
              ),
            ),
            selected == index
                ? Container(
              height: 22,
              width: 22,
              decoration: const BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.done,
                color: whiteColor,
                size: 14,
              ),
            )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  textField(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(color: blackColor.withOpacity(0.25), blurRadius: 6)
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: primaryColor)),
        child: child,
      ),
    );
  }

  tabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding),
      child: Row(
        children: List.generate(
          tabbarlist.length,
              (index) => Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedPayMethod = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: fixPadding),
                padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                height: 60,
                decoration: BoxDecoration(
                  color: selectedPayMethod == index ? primaryColor : whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: blackColor.withOpacity(0.25),
                      blurRadius: 6,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  child: Center(
                    child: Text(
                      tabbarlist[index],
                      style: selectedPayMethod == index
                          ? bold16White
                          : bold16Grey87,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  currentLoansListContent() {
    return ColumnBuilder(
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(
              vertical: fixPadding, horizontal: fixPadding * 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
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
                    Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(fixPadding / 1.2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFfEDEBEB),
                      ),
                      child: Image.asset(
                        "assets/loan/home-database.png",
                      ),
                    ),
                    widthSpace,
                    width5Space,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            returnLoans[index]['Description'].toString(),
                            style: bold16Black33,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            returnLoans[index]['AccountId'].toString(),
                            style: semibold14Grey94,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    Text(
                      returnLoans[index]['DisbursedAmount'].toString(),
                      style: bold16Primary,
                    )
                  ],
                ),
              ),
              dottedLine(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: fixPadding * 2,
                  vertical: fixPadding,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: infoWidget(
                        getTranslation(context, 'loans.period'),
                        '${returnLoans[index]['Term']} Months',
                      ),
                    ),
                    Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: infoWidget(
                            getTranslation(context, 'loans.rate'),
                            "${returnLoans[index]['effectiverate']} ${getTranslation(context, 'loans.rate_text')}",
                          ),
                        )),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: infoWidget(
                          getTranslation(context, 'loans.EMI'),
                          returnLoans[index]['InstallmentAmount'].toString(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/loanStatement');
                },
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5C4C4),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10.0),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    getTranslation(context, 'loans.view_statement'),
                    style: bold16Primary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: returnLoans.length,
    );
  }

  infoWidget(String title, String detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: semibold14Grey94,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          detail,
          style: semibold16Black33,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  dottedLine() {
    return DottedBorder(
      padding: EdgeInsets.zero,
      color: primaryColor,
      dashPattern: const [2, 3],
      child: Container(),
    );
  }

  newGroupButton() {
    return GestureDetector(
      onTap: () async {

        String NewGroupName=newGroupName.text;
        String NewGroupDesc=newGroupDescription.text;
        String NewGroupMeetingName=newGroupMeetingDate.text;

        if (NewGroupName == '' || NewGroupDesc == '' || NewGroupMeetingName== '')
        {
          showErrorMessage('Please provide all fields before proceeding!');
        }else
        {
          final String token = APIauthToken;

          final Map<String, String> headers = {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          };
          //Call Core to Populate the data Below
          Map<String, String> requestBody = {
            'MobileNumber': AppMobile,
            'DeviceNumber': deviceCode,
            'GroupName': NewGroupName,
            'GroupDescription': NewGroupDesc,
            'GroupMeetingDate': NewGroupMeetingName
          };
          print('Calling Group Details..');
          try {
            var response = await http.post(
              Uri.parse(APICreateGroupDetails),
              body: jsonEncode(requestBody),
              headers: headers,
            );
            Map<String, dynamic> jsonResponse = json.decode(
                response.body);
            int statusCode = response.statusCode;

            if (statusCode == 403) {
              showErrorMessage('Invalid Session Details.');
            } else if (statusCode == 404) {
              setState(() {
                groupNameController.text  =  '';
                schemeNameController.text = '';
                registrationDateController.text = '';
                groupOfficerController.text = '';
                membersController.text = '';
              });
              showErrorMessage('Group Details Not Found.');
            } else if (statusCode == 500) {
              showErrorMessage('An error occurred. Please contact the System Admin');
            }else
            {
              late List<dynamic> returnDetails=[];
              returnMembers=[];
              returnDetails = jsonResponse['returnDetails'];
              returnMembers = jsonResponse['returnMembers'];
              setState(() {
                groupNameController.text  = returnDetails[0]['GroupName']?.toString() ?? 'Null';
                schemeNameController.text = returnDetails[0]['SchemeName']?.toString() ?? 'Null';
                registrationDateController.text = returnDetails[0]['RegistrationDate']?.toString() ?? 'Null';
                groupOfficerController.text = returnDetails[0]['GroupOfficer']?.toString() ?? 'Null';
                membersController.text = returnDetails[0]['Members']?.toString() ?? 'Null';
                groupIdController.text =  returnDetails[0]['GroupId']?.toString() ?? 'Null';
                showInfoMessage('Group Created:${returnDetails[0]['GroupId']!} - Proceed to add Group Members');

                newGroupName.text='';
                newGroupDescription.text ='';
                newGroupMeetingDate.text ='';

              });

            }
          }catch (error) {
            // Handle network-related errors
            Navigator.of(context).pop();
            showErrorMessage('Network error during Login: $error');
          }

        }

      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(fixPadding * 1.5),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslation(context, 'groups.group_create'),
          style: bold18White,
        ),
      ),
    );
  }


  newMemberButton() {
    return GestureDetector(
      onTap: () async {
        //Navigator.pushNamed(context, '/successgroups');
        double? sumLoans = 0;
        double? sumSavings = 0;
        int countLoans= 0;
        bool isComplete = true;
        for (int i = 0; i < returnMembers.length; i++) {
          if(returnMembers[i]['LoanCollectionAmount']!='') {
            sumLoans = (sumLoans! + double.parse(returnMembers[i]['LoanCollectionAmount']));
            countLoans = countLoans+1;
          }

          if(returnMembers[i]['SavingsCollection']!='') {
            sumSavings = (sumSavings! + double.parse(returnMembers[i]['SavingsCollection']));
          }

        }

        if (countLoans == 0)
        {
          showErrorMessage('No Collections Found.');
          return;
        }



        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirmation'),
              content: Text('Are you sure you want to post Loan Repayments totalling '+ sumLoans.toString()!+' and Group Savings totalling '+sumSavings.toString()!+' for the Group?'),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    newMemberIdController.text='';
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
                TextButton(
                  child: Text('Confirm'),
                  onPressed: () {

                    //Post Transaction

                    PostCollections(postGroupId,postGroupGl,sumSavings.toString(),sumLoans.toString());
                    showInfoMessage("Group Collections Posted!");

                    setState(() {
                      groupNameController.text  =  '';
                      schemeNameController.text = '';
                      registrationDateController.text = '';
                      groupOfficerController.text = '';
                      membersController.text = '';
                      groupIdController.text='';
                      returnMembers=[];

                    });

                    Navigator.of(context).pop(); // Close the dialog

                  },
                ),
              ],
            );
          },
        );



      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(fixPadding * 1.5),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslation(context, 'collections.applications'),
          style: bold18White,
        ),
      ),
    );
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          content: Text(message),
          backgroundColor: Colors.red, // Optional background color
          behavior: SnackBarBehavior.floating, // Optional behavior
        )
    );
  }

  void showInfoMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          content: Text(message),
          backgroundColor: Colors.blue, // Optional background color
          behavior: SnackBarBehavior.floating, // Optional behavior
        )
    );
  }

  void refreshContainer() {
    setState(() {});
  }

  Future<void> AddMemberToGroup(String GroupId,CustomerId)  async {

    final String token = APIauthToken;

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    //Call Core to Populate the data Below
    Map<String, String> requestBody = {
      'MobileNumber': AppMobile,
      'DeviceNumber': deviceCode,
      'GroupId': GroupId,
      'CustomerId': CustomerId
    };
    print('Calling Add Group Customer Details..');
    try {
      var response = await http.post(
        Uri.parse(APIAddGroupCustomerDetails),
        body: jsonEncode(requestBody),
        headers: headers,
      );

      Map<String, dynamic> jsonResponse = json.decode(
          response.body);
      int statusCode = response.statusCode;

      if (statusCode == 403) {
        showErrorMessage('Invalid Session Details.');
      } else if (statusCode == 404) {
        showErrorMessage('Customer Details Not Added.');
      } else if (statusCode == 500) {
        showErrorMessage('An error occurred. Please contact the System Admin');
      } else {

        returnMembers = jsonResponse['returnDetails'];
        showInfoMessage('Group Member Added.');
        refreshContainer();

      }

    }catch (error) {
      // Handle network-related errors
      showErrorMessage('Network error during Login: $error');
    }

  }

  Future<void> PostCollections(String GroupId,String GroupGL,Savings,Repayments)  async {

    final String token = APIauthToken;

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    //Call Core to Populate the data Below
    Map<String, String> requestBody = {
      'MobileNumber': AppMobile,
      'DeviceNumber': deviceCode,
      'GroupId': GroupId,
      'GroupGL': GroupGL,
      'Savings': Savings,
      'Repayments': Repayments,
      'OfficerAccountId': detailsAccountId
    };
    //print(requestBody);
    try {
      var response = await http.post(
        Uri.parse(APIPostGroupCollections),
        body: jsonEncode(requestBody),
        headers: headers,
      );

      Map<String, dynamic> jsonResponse = json.decode(
          response.body);
      int statusCode = response.statusCode;

      if (statusCode == 403) {
        showErrorMessage('Invalid Session Details.');
      } else if (statusCode == 404) {
        showErrorMessage('Customer Details Not Added.');
      } else if (statusCode == 500) {
        showErrorMessage('An error occurred. Please contact the System Admin');
      } else {

        //returnMembers = jsonResponse['returnDetails'];
        showInfoMessage('Transactions Posted.');
        refreshContainer();

      }

    }catch (error) {
      // Handle network-related errors
      showErrorMessage('Network error during Login: $error');
    }

  }

  Future<void> PopulateGroupLoans(String GroupId)  async {
    final String token = APIauthToken;

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    //Call Core to Populate the data Below
    Map<String, String> requestBody = {
      'MobileNumber': AppMobile,
      'DeviceNumber': deviceCode,
      'GroupId': GroupId
    };
    print('Calling Add Group Loans Details..');
    try {
      var response = await http.post(
        Uri.parse(APIGroupLoans),
        body: jsonEncode(requestBody),
        headers: headers,
      );

      Map<String, dynamic> jsonResponse = json.decode(
          response.body);
      int statusCode = response.statusCode;

      if (statusCode == 403) {
        showErrorMessage('Invalid Session Details.');
      } else if (statusCode == 404) {
        showInfoMessage('Could not extract group loans.');
      } else if (statusCode == 500) {
        showErrorMessage('An error occurred. Please contact the System Admin');
      } else {

        returnLoans = jsonResponse['returnDetails'];
        showInfoMessage('Group Loans Loaded.');
        refreshContainer();

      }

    }catch (error) {
      // Handle network-related errors
      showErrorMessage('Network error during Login: $error');
    }
  }

}



