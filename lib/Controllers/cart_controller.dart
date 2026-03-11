import 'package:get/get.dart';
import 'package:shop4you/models/cart_model.dart';
import 'package:shop4you/models/products.dart';

import 'package:shop4you/util/cart_repo.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            price: value.price!.toInt(),
            quantity: value.quantity! + quantity,
            name: value.name,
            image: value.image,
            hasAddon: value.hasAddon,
            time: DateTime.now().toString(),
            isExist: true,
            product: product);
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
              id: product.id,
              price: product.price,
              quantity: quantity,
              name: product.name,
              image: product.image,
              hasAddon: product.hasAddon,
              time: DateTime.now().toString(),
              isExist: true,
              product: product);
        });
      } else {
        //TODO:Show message that you should add at least one  item
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) => e.value).toList();
  }

  int get totalAmount {
    var total = 0;

    _items.forEach((key, value) {
      total += (value.quantity! * value.price!);
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    print("Length of cart items " + storageItems.length.toString());
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  addtoHistory() {
    cartRepo.addToCartHistory();
    clear();
  }

  clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistory();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory() {
    cartRepo.clearCartHistory();
    update();
  }

  void removeCartSharedPreference() {
    cartRepo.removeCartSharedPreference();
  }
  // void checkout() {
  //   // _items.forEach((key, value) {
  //   //   cartRepo.addToCartList(cartList);
  //   // });
  //   if (getItems.isNotEmpty) {
  //     Get.snackbar("list Not Empty", "List is not Empty");
  //     List<CartModel> checkoutList =
  //         _items.entries.map((e) => e.value).toList();
  //     cartRepo.addToCartList(checkoutList);
  //   } else {
  //     Get.snackbar("Empty List", "Add items to the checkout list");
  //   }
  // }
}
