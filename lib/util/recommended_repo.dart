import 'package:get/get.dart';
import 'package:shop4you/util/apiClient.dart';

class RecommendedRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedRepo({required this.apiClient});
  Future<Response> getProductsList() async {
    //TODO: Input the right uri date
    return await apiClient.getData('/products');
  }
}
