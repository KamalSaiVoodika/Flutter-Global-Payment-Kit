var thisYear = DateTime.now().year.toString();

const String appName = "My App"; //this shows in the splash screen
String copyrightText =
    "@ $appName " + thisYear; //this shows in the splash screen

//full url = https://dev-grif.1129-1891.cyou/api/v1/logout
//configure this
const bool https = true;

//configure this
const domainPath = "website.com"; // directly inside the public folder

//do not configure these below
const String apiEndPath = "index.php";
const String publicFolder = "public";
const String protocol = https ? "https://" : "http://";
const String rawBaseUrl = "$protocol$domainPath";
const String baseUrl = "$rawBaseUrl/$apiEndPath";

//configure this if you are using amazon s3 like services
//give direct link to file like https://[[bucketname]].s3.ap-southeast-1.amazonaws.com/
//otherwise do not change anythink

//woocommerce api end point
const String productList = '/products';
