import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

Future<bool> get hasInternet async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  } else {
    return true;
  }
}

void kPrint(dynamic value){
  if (kDebugMode) {
    print(value);
  }
}
