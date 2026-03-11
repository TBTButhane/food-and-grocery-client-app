// import 'package:get/get.dart';
// import 'package:shop4you/Controllers/cart_controller.dart';
// import 'package:shop4you/models/cart_model.dart';
// import 'package:shop4you/models/test_model.dart';

// import 'package:shop4you/util/recommendedRepo.dart';



// class RecommendedProductController extends GetxController {
//   final RecommendedRepo recommendedProductRepo;

//   RecommendedProductController({required this.recommendedProductRepo});

//   List<dynamic> _productList = [];
//   List<dynamic> get getproductsList => _productList;
//   // late CartController _cartController;

//   Future<void> getProductList() async {
//     Response response = await recommendedProductRepo.getProductsList();

//     if (response.statusCode == 200) {
//       print("got all products");
//       // print(response.body);
//       _productList = [];
//       _productList.addAll(Product.fromJson(response.body).products);
//       update();
//     } else {
//       print("This is the response code: " + response.statusCode.toString());
//       //TODO: Do someting here
//     }
//   }

//   int _quantity = 0;
//   int get quantity => _quantity;
//   int _inCartItems = 0;
//   int get inCartItems => _inCartItems + _quantity;

//   void setQuantity(bool isInCrement) {
//     if (isInCrement) {
//       _quantity = checkQuantity(_quantity + 1);
//     } else {
//       _quantity = checkQuantity(_quantity - 1);
//     }

//     update();
//   }

//   int checkQuantity(int quantity) {
//     if ((_inCartItems + quantity) < 0) {
//       //TODO: Alert user that the number cant be less than 0
//       if (_inCartItems > 0) {
//         _quantity = -inCartItems;
//         return _quantity;
//       }
//       return 0;
//     } else if ((_inCartItems + quantity) > 30) {
//       //TODO: Alert user that the number cant be more than 30

//       return 30;
//     } else {
//       return quantity;
//     }
//   }

//   void initProduct(Product product, CartController cart) {
//     _quantity = 0;
//     _inCartItems = 0;
//     _cartController = cart;
//     var exist = false;
//     exist = _cartController.existInCart(product);

//     //if Exist
//     //get from storage
//     if (exist) {
//       _inCartItems = _cartController.getQuantity(product);
//     }
//   }

//   void addItem(
//     Product product,
//   ) {
//     _cartController.addItem(product, _quantity);
//     _quantity = 0;
//     _inCartItems = _cartController.getQuantity(product);
//     _cartController.items.forEach((key, value) {
//       print("The id is " +
//           value.id.toString() +
//           " The quantity is " +
//           value.quantity.toString());
//     });
//     update();
//   }

//   int get totalItems {
//     return _cartController.totalItems;
//   }

//   List<CartModel> get getItems {
//     return _cartController.getItems;
//   }
// }
