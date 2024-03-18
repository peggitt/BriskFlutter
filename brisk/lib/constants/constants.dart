const String APIPath = 'http://103.6.168.33:2770/'; //Airtel
//const String APIPath = 'http://192.168.100.204:2770/'; //Home Wifi

const String APILogin1 = APIPath+'userlogin';
const String APILogin2 = APIPath+'userlogin2';
const String APIRegister = APIPath+'userregister';
const String APIRegisterBrisk = APIPath+'userregisterbrisk';
const String APIPinRegister = APIPath+'userpinregister';

const String APIAccounts = APIPath+'getAccounts';
const String APIBriskAccounts = APIPath+'getBriskAccounts';
const String APIAccountDetails = APIPath+'getAccountdetails';
const String APIAccountBriskDetails = APIPath+'getAccountBriskdetails';
const String APIAccountBriskBalance = APIPath+'getAccountBriskBalance';
const String APIAccountBriskLimit = APIPath+'getAccountBriskLimit';
const String APIAccountBriskLoanStatement = APIPath+'getAccountBriskLoanInstallment';
const String APIAccountStatementDetails = APIPath+'getAccountstatementdetails';

const String APIGroupDetails = APIPath+'getGroupdetails';
const String APICreateGroupDetails = APIPath+'createGroupdetails';
const String APISearchCustomerDetails = APIPath+'getCustomerdetails';
const String APIAddGroupCustomerDetails = APIPath+'addMemberGroupdetails';
const String APIGroupLoans = APIPath+'getGroupLoans';
const String APIPostGroupCollections = APIPath+'postGroupCollections';

const String APICreateCustomerDetails = APIPath+'createCustomerdetails';

const String APIInternalTransfer = APIPath+'postTransferTransaction';

String AppMobile = "";
String APIauthToken = "";
String deviceCode = "";