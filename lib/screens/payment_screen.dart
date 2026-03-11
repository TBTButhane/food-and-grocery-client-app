import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop4you/Controllers/cart_controller.dart';
import 'package:shop4you/models/order_model.dart';
import 'package:shop4you/models/place_order_model.dart';
import 'package:shop4you/routes/route_helper.dart';
import 'package:shop4you/widgets/big_text.dart';
import 'package:shop4you/widgets/dimentions.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/address_model.dart';

class PaymentScreen extends StatefulWidget {
  final OrderModel orderModel;
  const PaymentScreen({
    Key? key,
    required this.orderModel,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late String selectedUrl;
  double pageLoadValue = 0.0;
  bool _canRedirect = true;
  bool _isLoading = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late WebViewController controllerGlobal;
  late PlaceOrderModel placeOrderModel;
  late String placeOrderJson;
  @override
  void initState() {
    super.initState();

    placeOrderModel = Get.arguments;
    widget.orderModel.placeOrderDetails = placeOrderModel;
    placeOrderJson = toJson(placeOrderModel);
    widget.orderModel.deliveryAddress = AddressModel(
      addressType: 'Home',
      latitude: placeOrderModel.latitude,
      address: placeOrderModel.address,
      contactNumber: placeOrderModel.contactPersonNumber,
      contactPerson: placeOrderModel.contactPersonName,
      longitude: placeOrderModel.longitude,
    );
    placeOrderModel.scheduleAt = DateTime.now().toString();
    widget.orderModel.scheduledAt = placeOrderModel.scheduleAt;
    widget.orderModel.createdAt = DateTime.now().toString();
    widget.orderModel.orderAmount = placeOrderModel.orderAmount;
    widget.orderModel.orderNote = placeOrderModel.orderNote;
    widget.orderModel.orderStatus ="pending";
    widget.orderModel.paymentStatus = placeOrderModel.paymentMethod;

    selectedUrl = "hosttree.co.za";

    final WebViewController controller = WebViewController();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          setState(() {
            pageLoadValue = progress.toDouble();
          });
          print("this is the page load percentage $pageLoadValue");
          print(
              "This is the generated Order Number ${widget.orderModel.id} and user ID: ${widget.orderModel.userId}");
        },
        onPageStarted: (url) {
          setState(() {
            _isLoading = true;
          });
          Future.delayed(Duration(milliseconds: 2))
              .whenComplete(() => _redirect(url));
        },
        onPageFinished: (url) {
          setState(() {
            _isLoading = false;
          });
          Future.delayed(Duration(milliseconds: 3))
              .whenComplete(() => _redirect(url));
        },
      ))
      ..canGoBack()
      // ..loadHtmlString(selectedUrl);
      ..loadRequest(Uri.https(selectedUrl, '/testapi/payment.php/',
          {'query': placeOrderJson, 'orderNum': widget.orderModel.id}));
    // ..loadRequest(Uri.https(
    //     'sandbox.payfast.co.za', '/eng/process/', {'q': '$queryData'}));
    controllerGlobal = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.green,
            title: const BigText(text: "Payment", fontColor: Colors.white),
            centerTitle: true,
            leading: IconButton(
                onPressed: () => _exitApp(context),
                icon: const Icon(Icons.arrow_back_ios))),
        body: Center(
          child: SizedBox(
            width: Dimensions.screenWidth,
            child: Stack(
              children: [
                WebViewWidget(controller: controllerGlobal),
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              const AlwaysStoppedAnimation(Colors.green),
                          value: pageLoadValue,
                        ),
                      )
                    : SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _redirect(String url) {
    print("redirect: $url");
    bool _isSuccess = url.contains('success');
    bool _isFailed = url.contains('fail');
    bool _isCancel = url.contains('cancel');

    if (_isSuccess || _isFailed || _isCancel) {
      _canRedirect = false;
    }
    if (_isSuccess) {
      // go to success page
      Get.find<CartController>().addtoHistory();
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();

      Get.offNamed(
          arguments: widget.orderModel,
          RouteHelper.getOrderStatusPage(boolValue: _isSuccess.toString()));
    } else if (_isFailed || _isCancel) {
      // go to failed page
      _isFailed = false;
      _isCancel = false;
      Get.offNamed(
          arguments: widget.orderModel,
          RouteHelper.getOrderStatusPage(boolValue: _isCancel.toString()));
    }
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      return true;
    }
  }
}
