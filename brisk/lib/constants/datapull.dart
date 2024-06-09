import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

List<dynamic> returnDetails=[];
List<dynamic> statementData=[];
List<dynamic> returnAccountDetails=[];
List<dynamic> returnAccountStatementDetails=[];

List<dynamic> returnLoanDetails=[];
List<dynamic> returnLoanBalance=[];
List<dynamic> returnLoanLimit=[];
List<dynamic> returnLoanStatement=[];

String detailsAccountId='';
String detailsAccountIdBalance='';
String detailsAccountName='';
String GlobalAccount = '';

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
    statementData = jsonResponse['statementdata'];
    return 'Done';
  } catch (error) {
    // Handle network-related errors
    //print(error);
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



Future<String> DoLoanApplication(AccountId,LoanAmount,DailyExpenses,DailySales)
async {
  final String token = APIauthToken;
  int ResStatus = 0;

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  //Call Core to Populate the data Below
  Map<String, String> requestBody = {
    'MobileNumber': AppMobile,
    'DeviceNumber': deviceCode,
    'AccountNumber': AccountId,
    'loan_amount': LoanAmount,
    'estimated_daily_sales': DailySales,
    'daily_expenses': DailyExpenses
  };
  print('Calling Loan Application..');
  try   {
    var response = await http.post(
      Uri.parse(APILoanApplicationBrisk),
      body: jsonEncode(requestBody),
      headers: headers,
    );
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    ResStatus = jsonResponse['status'];
    if (ResStatus == 200) {
      return 'Done';
    }
    else
      {
        return 'Error';
      }

  } catch (error) {
    // Handle network-related errors
    return 'Error';
  }
}

