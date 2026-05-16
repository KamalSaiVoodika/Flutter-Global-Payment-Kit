import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter_sslcommerz/model/SSLCAdditionalInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCCustomerInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCEMITransactionInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCShipmentInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/General.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/SSLCProductInitializer.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:get/get.dart';
import 'package:mystarter/constants/strings.dart';
import 'package:mystarter/constants/style_data.dart';
import 'package:mystarter/view/screens/gateway/braintree_screen.dart';
import 'package:mystarter/view/screens/gateway/flutter_wave_screen.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../constants/size_config.dart';
import '../../../helper/stripe_payment_helpter.dart';
import '../../widgets/default_btn.dart';
import '../gateway/paystack_screen.dart';
import '../gateway/paytm_screeen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //ssl commerz
  dynamic formData = {};

  //razorpay
  late Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    //razorpay
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    //end razorpay
  }

  @override
  void dispose() {
    super.dispose();
    //razorpay
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Gateway List'.tr,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeightBox30,
              DefaultBtn(
                width: SizeConfig.screenWidth,
                radius: 10.0,
                title: 'Stripe'.tr,
                onPress: () async {
                  await StripePaymentHelper().makePayment(
                    context: context,
                    amount: '250',
                  );
                },
              ),
              kHeightBox10,
              DefaultBtn(
                width: SizeConfig.screenWidth,
                radius: 10.0,
                title: 'Paypal'.tr,
                onPress: () async {
                  handlePaypalPayment(
                    context,
                  );
                },
              ),
              kHeightBox10,
              DefaultBtn(
                width: SizeConfig.screenWidth,
                radius: 10.0,
                title: 'Flutterwave'.tr,
                onPress: () async {
                  Get.to(() => const FlutterWaveScreen());
                },
              ),
              kHeightBox10,
              DefaultBtn(
                width: SizeConfig.screenWidth,
                radius: 10.0,
                title: 'Pastack'.tr,
                onPress: () async {
                  Get.to(() => const PayStackScreen());
                },
              ),
              kHeightBox10,
              DefaultBtn(
                width: SizeConfig.screenWidth,
                radius: 10.0,
                title: 'Razorpay'.tr,
                onPress: openCheckout,
              ),
              kHeightBox10,
              DefaultBtn(
                width: SizeConfig.screenWidth,
                radius: 10.0,
                title: 'Braintree'.tr,
                onPress: () async {
                  Get.to(() => const BraintreeScreen());
                },
              ),
              kHeightBox10,
              DefaultBtn(
                width: SizeConfig.screenWidth,
                radius: 10.0,
                title: 'SSL Commerz'.tr,
                onPress: () async {
                  await sslCommercePayment(context);
                },
              ),
              kHeightBox10,
              DefaultBtn(
                width: SizeConfig.screenWidth,
                radius: 10.0,
                title: 'Paytm'.tr,
                onPress: () async {
                  Get.to(() => const PaytmScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> handlePaypalPayment(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => UsePaypal(
          sandboxMode: true,
          clientId: kPaypalClientId,
          secretKey: kPaypalSecretKey,
          returnURL: "https://samplesite.com/return",
          cancelURL: "https://samplesite.com/cancel",
          transactions: const [
            {
              "amount": {
                "total": '200.12',
                "currency": "USD",
                "details": {
                  "subtotal": '200.12',
                  "shipping": '0',
                  "shipping_discount": 0
                }
              },
              "description": "The payment transaction description.",
              "item_list": {
                "items": [
                  {
                    "name": "A demo product",
                    "quantity": 1,
                    "price": '200.12',
                    "currency": "USD"
                  }
                ],

                // shipping address is not required though
                "shipping_address": {
                  "recipient_name": kName,
                  "line1": "Travis County",
                  "line2": "",
                  "city": "Austin",
                  "country_code": "US",
                  "postal_code": "73301",
                  "phone": "+00000000",
                  "state": "Texas"
                },
              }
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            log("onSuccess: $params");
          },
          onError: (error) {
            log("onError: $error");
          },
          onCancel: (params) {
            log('cancelled: $params');
          },
        ),
      ),
    );
  }

  Future<void> sslCommercePayment(BuildContext context) async {
    Sslcommerz sslCommerce = Sslcommerz(
      initializer: SSLCommerzInitialization(
        multi_card_name: formData['multicard'],
        currency: SSLCurrencyType.BDT,
        product_category: "Test",

        ///SSL SandBox ///
        ipn_url: "www.ipnurl.com",
        sdkType: SSLCSdkType.TESTBOX,
        store_id: 'testi6119f4717446f',
        store_passwd: 'testi6119f4717446f@ssl',

        ///SSL SandBox End///
        total_amount: 150.00,
        tran_id: DateTime.now().microsecondsSinceEpoch.toString(),
      ),
    );
    sslCommerce
        .addEMITransactionInitializer(
          sslcemiTransactionInitializer: SSLCEMITransactionInitializer(
            emi_options: 1,
            emi_max_list_options: 3,
            emi_selected_inst: 2,
          ),
        )
        .addShipmentInfoInitializer(
          sslcShipmentInfoInitializer: SSLCShipmentInfoInitializer(
            shipmentMethod: "yes",
            numOfItems: 10,
            shipmentDetails: ShipmentDetails(
              shipAddress1: 'Uttara-7,Dhaka',
              shipCity: 'Dhaka',
              shipCountry: 'Bangladesh',
              shipName: 'your ship name',
              shipPostCode: '1230',
            ),
          ),
        )
        .addCustomerInfoInitializer(
          customerInfoInitializer: SSLCCustomerInfoInitializer(
            customerName: kName,
            customerEmail: kEmail,
            customerAddress1: 'uttaha,dhaka-1230',
            customerState: '',
            customerCity: '',
            customerPostCode: '1230',
            customerCountry: 'Bangladesh',
            customerPhone: kPhone,
          ),
        )
        .addProductInitializer(
          sslcProductInitializer: SSLCProductInitializer(
            productName: "Gadgets",
            productCategory: "Widgets",
            general: General(
              general: "General Purpose",
              productProfile: "Product Profile",
            ),
          ),
        )
        .addAdditionalInitializer(
          sslcAdditionalInitializer: SSLCAdditionalInitializer(
            valueA: "app",
            valueB: "value b",
            valueC: "value c",
            valueD: "value d",
          ),
        );
    var result = await sslCommerce.payNow();
    log('ssl Result ====>' + result.toString());
    if (result is PlatformException) {
      log("the response is: " +
          result.message.toString() +
          " code: " +
          result.code.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message ?? ''),
        ),
      );
    } else {
      SSLCTransactionInfoModel model = result;
      log("ssL json" + model.toJson().toString());
      if (model.aPIConnect == 'DONE' && model.status == 'VALID') {
        showCustomSnackBar('Payment success', isError: false);
      } else {
        showCustomSnackBar('Payment Failed');
      }
    }
  }

  ///razorpay
  void openCheckout() async {
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': 250,
      'name': kName,
      'description': 'RTX 3090ti',
      'retry': {
        'enabled': true,
        'max_count': 1,
      },
      'send_sms_hash': true,
      'prefill': {
        'contact': kPhone,
        'email': kEmail,
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    showCustomSnackBar("SUCCESS: " + response.paymentId!, isError: false);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showCustomSnackBar(
      "ERROR: " + response.code.toString() + " - " + response.message!,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showCustomSnackBar(
      "EXTERNAL_WALLET: " + response.walletName!,
    );
  }///end razor pay

}
