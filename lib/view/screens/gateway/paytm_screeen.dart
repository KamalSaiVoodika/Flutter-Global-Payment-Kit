import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'widgets/text_filed.dart';

class PaytmScreen extends StatefulWidget {
  const PaytmScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<PaytmScreen> {
  String mid = "mid_id", orderId = "", amount = "", txnToken = "";
  String result = "";
  bool isStaging = false;
  bool isApiCallInprogress = false;
  String callbackUrl = "";
  bool restrictAppInvoke = false;
  bool enableAssist = true;

  @override
  void initState() {
    log("initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Paytm".tr),),
      body: Card(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                EditText('Merchant ID', mid, onChange: (val) => mid = val),
                EditText('Order ID', orderId, onChange: (val) => orderId = val),
                EditText('Amount', amount, onChange: (val) => amount = val),
                EditText('Transaction Token', txnToken,
                    onChange: (val) => txnToken = val),
                EditText('CallBack URL', callbackUrl,
                    onChange: (val) => callbackUrl = val),
                Row(
                  children: <Widget>[
                    Checkbox(
                        activeColor: Theme.of(context).disabledColor,
                        value: isStaging,
                        onChanged: (bool? val) {
                          setState(() {
                            isStaging = val!;
                          });
                        }),
                    const Text("Staging")
                  ],
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                        activeColor: Theme.of(context).disabledColor,
                        value: restrictAppInvoke,
                        onChanged: (bool? val) {
                          setState(() {
                            restrictAppInvoke = val!;
                          });
                        }),
                    const Text("Restrict AppInvoke")
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: isApiCallInprogress
                        ? null
                        : () {
                      _startTransaction();
                    },
                    child: const Text('Start Transcation'),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text("Message : "),
                ),
                Text(result),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _startTransaction() async {
    if (txnToken.isEmpty) {
      return;
    }
    var sendMap = <String, dynamic>{
      "mid": mid,
      "orderId": orderId,
      "amount": amount,
      "txnToken": txnToken,
      "callbackUrl": callbackUrl,
      "isStaging": isStaging,
      "restrictAppInvoke": restrictAppInvoke,
      "enableAssist": enableAssist
    };
    log(sendMap.toString());
    try {
      var response = AllInOneSdk.startTransaction(mid, orderId, amount,
          txnToken, callbackUrl, isStaging, restrictAppInvoke, enableAssist);
      response.then((value) {
        log(value.toString());
        setState(() {
          result = value.toString();
        });
      }).catchError((onError) {
        if (onError is PlatformException) {
          setState(() {
            result = onError.message.toString() +
                " \n  " +
                onError.details.toString();
          });
        } else {
          setState(() {
            result = onError.toString();
          });
        }
      });
    } catch (err) {
      result = err.toString();
    }
  }
}
