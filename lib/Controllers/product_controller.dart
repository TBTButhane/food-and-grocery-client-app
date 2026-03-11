import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shop4you/Controllers/cart_controller.dart';
import 'package:shop4you/models/cart_model.dart';
import 'package:shop4you/models/restaurant_model.dart';
import 'package:shop4you/models/products.dart';
import 'package:shop4you/util/popular_repo.dart';

class PopularProductController extends GetxController {
  final ProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _productList = [];
  List<dynamic> get getproductsList => _productList;
  List<dynamic> _popularProduct = [];
  List<dynamic> get getPopularProduct => _popularProduct;
  List<RestaurantsModel> _resList = [];
  List<RestaurantsModel> get resList => _resList;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late CartController _cartController;
  DocumentSnapshot? lastDoc;
  DocumentSnapshot? proLastDoc;

  @override
  onReady() {
    getRestaurants();
  }

  Future<void> getRestaurants() async {
    _isLoading = true;
    List<RestaurantsModel> docResList =
        await popularProductRepo.getRestaurantList(lastDoc);
    update();
    for (var element in docResList) {
      _resList.add(element);
    }
    _isLoading = false;
    update();
  }

  Future<void> getProducts() async {
    _isLoading = true;
    List<ProductModel> docProList =
        await popularProductRepo.getProductsList(proLastDoc);
    _productList = [];
    update();

    for (var element in docProList) {
      if (element.popular != true) {
        _productList.add(element);
      } else {
        _popularProduct.add(element);
      }
    }
    _isLoading = false;
    update();
  }

//Product Mock data
  // Future<void> getProductListMethod() async {
  //   var response = await rootBundle.loadString("assets/json/products.json");

  //   var data = await json.decode(response);

  //   if (data != null) {
  //     _productList = [];

  //     _productList.addAll(Shop4You.fromJson(data).products);

  //     print(_productList[0].name);

  //     update();
  //   } else {
  //     print("This is the response code: " + data.toString());
  //     //TODO: Do someting here
  //   }
  // }

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  void setQuantityZero(){
    _quantity=0;
    update();
  }

  void setQuantity(bool boolValue) {
    bool isInCrement = boolValue;
    update();
    if (isInCrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item Count", "You can't reduce more!",
          backgroundColor: Colors.green, colorText: Colors.white);

      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        // _quantity = _inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar("Item Count", "You can't add more!",
          backgroundColor: Colors.green, colorText: Colors.white);

      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cart;
    var exist = false;
    exist = _cartController.existInCart(product);

    // if Exist
    // get from storage
    if (exist) {
      _inCartItems = _cartController.getQuantity(product);
    }
  }

  void addItem(
    ProductModel product,
  ) {
    _cartController.addItem(
      product,
      _quantity,
    );
    _quantity = 0;
    _inCartItems = _cartController.getQuantity(product);
    _cartController.items.forEach((key, value) {
      print("The id is " +
          value.id.toString() +
          " The quantity is " +
          value.quantity.toString());
    });
    update();
  }

  int get totalItems {
    return _cartController.totalItems;
  }

  List<CartModel> get getItems {
    return _cartController.getItems;
  }
}
