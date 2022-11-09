import 'dart:developer';
import 'dart:io';

mixin MyConnectivity {
  Future<bool> isConnected();
}

class MyConnectivityImpl implements MyConnectivity {
  @override
  Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (e) {
      log(e.message, name: 'isConnected', error: e);
    }
    return false;
  }
}
