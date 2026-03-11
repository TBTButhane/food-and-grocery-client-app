import 'package:get/get.dart';
// import 'package:shop4you/routes/route_helper.dart';
import 'package:shop4you/widgets/custome_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      // Get.offNamed(RouteHelper.getSignInPage());
      shoeCustomSnackbar(response.statusText!);
    } else {
      shoeCustomSnackbar(response.statusText!);
    }
  }
}
