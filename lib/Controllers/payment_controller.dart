// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shop4you/models/order_model.dart';
import 'package:shop4you/util/payment_repo.dart';

class PaymentController extends GetxController implements GetxService {
  PaymentRepo paymentRepo;
  PaymentController({
    required this.paymentRepo,
  });
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late OrderModel orderModel;
  // final FirebaseFirestore _fStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<OrderModel> _currentOrderList = [];
  late List<OrderModel> _generalOrderList;
  List<OrderModel> _historyOrderList = [];
  String _orderType = "delivery";
  String get orderType => _orderType;
  int _paymentIndex = 0;
  int get paymentIndex => _paymentIndex;
  String _footNote = "";
  String get footNote => _footNote;
  int deliveryAmount = 35;
  List<OrderModel> get generalOrderList => _generalOrderList;
  List<OrderModel> get currentOrderList => _currentOrderList;
  List<OrderModel> get historyOrderList => _historyOrderList;
  late double tempZar;

  //Get orders from users collections
  Future<void> userOrderList() async {
    _isLoading = true;
    _currentOrderList = [];
    _historyOrderList = [];
    String userId = _auth.currentUser!.uid;
    List<OrderModel> ordersList = await paymentRepo.userOrderList(userId);
    for (var element in ordersList) {
      if (element.orderStatus == 'pending' ||
          element.orderStatus == 'accepted' ||
          element.orderStatus == 'processing' ||
          element.orderStatus == 'handover' ||
          element.orderStatus == 'picked up'||
          element.orderStatus == 'confirmed') {
        _currentOrderList.add(element);
      } else {
        _historyOrderList.add(element);
      }
    }
    _isLoading = false;
    update();
  }

  //get general list of orders, this is for generating order numbers
  Future<void> ordersList() async {
    _isLoading = true;
    _generalOrderList = [];
    List<OrderModel> generalOrderList = await paymentRepo.ordersList();
    for (var element in generalOrderList) {
      _generalOrderList.add(element);
    }
    _isLoading = false;
    update();
  }

  //GenerateOrdersList
  Future<double> generateOrdersNumber() async {
    await ordersList();
    late double orderNumber;
    double orderfromStart = 1;
    if (_generalOrderList.isEmpty) {
      orderNumber = orderfromStart;
      update();
      return orderNumber;
    } else {
      orderNumber = _generalOrderList.length + orderfromStart;
      update();
      return orderNumber;
    }
  }

  Future<void> saveOrders(OrderModel orderModel, String userId) async {
    _isLoading = true;
    // update();
    await paymentRepo.saveOrders(orderModel, userId);
    _isLoading = false;
    update();
  }

  //handle payment

  //handle transaction cancel

  // handle refund

  void setPaymentIndex(int index) {
    _paymentIndex = index;
    update();
  }

  void setDeliveryType(String type) {
    _orderType = type;
    update();
  }

  void setFoodNote(String note) {
    _footNote = note;
  }
}
