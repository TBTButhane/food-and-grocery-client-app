import 'dart:convert';
import 'package:shop4you/models/cart_model.dart';
import 'package:shop4you/util/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences getStorage;
  CartRepo({required this.getStorage});

  List<String> carts = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    // getStorage.remove(cart_list);
    // getStorage.remove(cartHistList);
    var time = DateTime.now().toString();
    carts = [];

    for (var element in cartList) {
      element.time = time;
      carts.add(jsonEncode(element));
    }
    // for (var i = 0; i < cartList.length; i++) {
    //   cartList[i].time = time;
    //   carts.add(jsonEncode(i));
    // }

    // getStorage.write(cart_list, carts);
    //
    getStorage.setStringList(cart_list, carts);
    //
    // getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    // if (getStorage.hasData(cart_list)) {
    //   carts = getStorage.read(cart_list);
    // }
    if (getStorage.containsKey(cart_list)) {
      carts = getStorage.getStringList(cart_list)!;
    }
    List<CartModel> cartList = [];

    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    // for (var i = 0; i < cart.length; i++) {
    //   cartList.add(CartModel.fromJson(jsonDecode(cart[i])));
    // }

    return cartList;
  }

  List<CartModel> getCartHistory() {
    if (getStorage.containsKey(cartHistList)) {
      // cartHistory = [];
      cartHistory = getStorage.getStringList(cartHistList)!;
    }
    List<CartModel> cartHistoryList = [];

    for (var element in cartHistory) {
      cartHistoryList.add(CartModel.fromJson(jsonDecode(element)));
    }
    // for (var i = 0; i < cartHistory.length; i++) {
    //   cartHistoryList.add(CartModel.fromJson(jsonDecode(cartHistory[i])));
    // }
    return cartHistoryList;
  }

  void addToCartHistory() {
    if (getStorage.containsKey(cartHistList)) {
      cartHistory = getStorage.getStringList(cartHistList)!;
    }
    for (var element in carts) {
      cartHistory.add(element);
    }

    carts = [];
    getStorage.setStringList(cartHistList, cartHistory);
  }

  void removeCart() {
    carts = [];
    getStorage.remove(cart_list);
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    getStorage.remove(cartHistList);
  }

  void removeCartSharedPreference() {
    getStorage.remove(cart_list);
    getStorage.remove(cartHistList);
  }
}
