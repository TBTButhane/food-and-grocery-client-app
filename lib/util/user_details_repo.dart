import 'package:shop4you/util/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailRepo {
  final SharedPreferences getStorage;
  UserDetailRepo({required this.getStorage});

  //Save user info offline/locally
  storeUserProfileData(String userdata) {
    getStorage.setString(userdetails, userdata);
  }

//get user data locally
  String getStoredUserData() {
    var getStoreddata = getStorage.get(userdetails);

    String storeddata = getStoreddata.toString();
    return storeddata;
  }
}
