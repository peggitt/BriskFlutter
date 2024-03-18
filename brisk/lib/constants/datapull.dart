import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

late List<dynamic> returnDetails=[];
late List<dynamic> statementData=[];
late List<dynamic> returnAccountDetails=[];
late List<dynamic> returnAccountStatementDetails=[];

late List<dynamic> returnLoanDetails=[];
late List<dynamic> returnLoanBalance=[];
late List<dynamic> returnLoanLimit=[];
late List<dynamic> returnLoanStatement=[];

String detailsAccountId='';
String detailsAccountIdBalance='';
String detailsAccountName='';

String postGroupId='';
String postGroupGl='';

String TransferAccountName='';
String TransferAmount='';
String TransferFromAccount = '';
String TransactionDesc = '';

Future<String> GetAccounts()
async {
  final String token = APIauthToken;

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  //Call Core to Populate the data Below
  Map<String, String> requestBody = {
    'MobileNumber': AppMobile,
    'DeviceNumber': deviceCode
  };
  print('Calling Accounts..');
  try   {
    var response = await http.post(
      Uri.parse(APIBriskAccounts),
      body: jsonEncode(requestBody),
      headers: headers,
    );
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    //print(jsonResponse);
    returnDetails = jsonResponse['returnDetails'];
    print(returnDetails);
    statementData = jsonResponse['statementdata'];
    return 'Done';
  } catch (error) {
    // Handle network-related errors
    return 'Done';
  }
}

Future<String> GetAccountDetails(AccountId)
async {
  final String token = APIauthToken;

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  //Call Core to Populate the data Below
  Map<String, String> requestBody = {
    'MobileNumber': AppMobile,
    'DeviceNumber': deviceCode,
    'AccountNumber': AccountId
  };
  print('Calling Account Details..');
  try   {
    var response = await http.post(
      Uri.parse(APIAccountBriskDetails),
      body: jsonEncode(requestBody),
      headers: headers,
    );
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    returnAccountDetails = jsonResponse['returnDetails'];
    detailsAccountId = AccountId;
    detailsAccountIdBalance = returnAccountDetails[0]['ClearBalance'].toString();
    detailsAccountName = returnAccountDetails[0]['AccountName'].toString();
    return 'Done';
  } catch (error) {
    // Handle network-related errors
    return 'Done';
  }
}



Future<String> GetLoanDetails(AccountId)
async {
  final String token = APIauthToken;

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  //Call Core to Populate the data Below
  Map<String, String> requestBody = {
    'MobileNumber': AppMobile,
    'DeviceNumber': deviceCode,
    'AccountNumber': AccountId
  };
  print('Calling Loan Details..');
  try   {
    var response = await http.post(
      Uri.parse(APIAccountBriskDetails),
      body: jsonEncode(requestBody),
      headers: headers,
    );
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    returnLoanDetails = jsonResponse['returnDetails'];
    detailsAccountId = AccountId;
    //detailsAccountIdBalance = returnAccountDetails[0]['ClearBalance'].toString();
    //detailsAccountName = returnAccountDetails[0]['AccountName'].toString();
    return 'Done';
  } catch (error) {
    // Handle network-related errors
    return 'Done';
  }
}



Future<String> GetLoanBalance(AccountId)
async {
  final String token = APIauthToken;

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  //Call Core to Populate the data Below
  Map<String, String> requestBody = {
    'MobileNumber': AppMobile,
    'DeviceNumber': deviceCode,
    'AccountNumber': AccountId
  };
  print('Calling Loan Balance..');
  try   {
    var response = await http.post(
      Uri.parse(APIAccountBriskBalance),
      body: jsonEncode(requestBody),
      headers: headers,
    );
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    returnLoanBalance = jsonResponse['returnDetails'];
    detailsAccountId = AccountId;
    //detailsAccountIdBalance = returnAccountDetails[0]['ClearBalance'].toString();
    //detailsAccountName = returnAccountDetails[0]['AccountName'].toString();
    return 'Done';
  } catch (error) {
    // Handle network-related errors
    return 'Done';
  }
}



Future<String> GetLoanLimit(AccountId)
async {
  final String token = APIauthToken;

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  //Call Core to Populate the data Below
  Map<String, String> requestBody = {
    'MobileNumber': AppMobile,
    'DeviceNumber': deviceCode,
    'AccountNumber': AccountId
  };
  print('Calling Loan limit..');
  try   {
    var response = await http.post(
      Uri.parse(APIAccountBriskLimit),
      body: jsonEncode(requestBody),
      headers: headers,
    );
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    returnLoanLimit = jsonResponse['returnDetails'];
    detailsAccountId = AccountId;
    //detailsAccountIdBalance = returnAccountDetails[0]['ClearBalance'].toString();
    //detailsAccountName = returnAccountDetails[0]['AccountName'].toString();
    return 'Done';
  } catch (error) {
    // Handle network-related errors
    return 'Done';
  }
}



Future<String> GetLoanStatement(AccountId)
async {
  final String token = APIauthToken;

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  //Call Core to Populate the data Below
  Map<String, String> requestBody = {
    'MobileNumber': AppMobile,
    'DeviceNumber': deviceCode,
    'AccountNumber': AccountId
  };
  print('Calling Loan statement..');
  try   {
    var response = await http.post(
      Uri.parse(APIAccountBriskLoanStatement),
      body: jsonEncode(requestBody),
      headers: headers,
    );
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    returnLoanStatement = jsonResponse['returnDetails'];
    detailsAccountId = AccountId;
    //detailsAccountIdBalance = returnAccountDetails[0]['ClearBalance'].toString();
    //detailsAccountName = returnAccountDetails[0]['AccountName'].toString();
    return 'Done';
  } catch (error) {
    // Handle network-related errors
    return 'Done';
  }
}

Future<String> GetAccountStatementDetails(AccountId,FromDate,ToDate)
async {
  final String token = APIauthToken;

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  //Call Core to Populate the data Below
  Map<String, String> requestBody = {
    'MobileNumber': AppMobile,
    'DeviceNumber': deviceCode,
    'AccountNumber': AccountId,
    'FromDate': FromDate,
    'ToDate': ToDate
  };
  print('Calling Account Statement Details..');
  try   {
    var response = await http.post(
      Uri.parse(APIAccountStatementDetails),
      body: jsonEncode(requestBody),
      headers: headers,
    );
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    //print(jsonResponse);
    returnAccountStatementDetails = jsonResponse['returnDetails'];
    //print(returnAccountStatementDetails);
    return 'Done';
  } catch (error) {
    // Handle network-related errors
    return 'Done';
  }
}