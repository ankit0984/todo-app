import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Function to go back to the previous screen
  void back() {
    Get.back();
  }

  /// Add more signup logic here (e.g., registration)
}
