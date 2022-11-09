import 'dart:developer';

import 'package:encrypt/encrypt.dart' as encrypt;

class Cipher {
  final String _key = "Ps3RtG5678GFv3sD";
  final String _iv = "3NcR7pT3rPs3V3cT";

  String encryptAES(String plaintText) {
    final key = encrypt.Key.fromUtf8(_key);
    final iv = encrypt.IV.fromUtf8(_iv);

    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final encrypted = encrypter.encrypt(plaintText, iv: iv);

    return encrypted.base64;
  }

  String decryptAES(String encrypText) {
    final key = encrypt.Key.fromUtf8(_key);
    final iv = encrypt.IV.fromUtf8(_iv);

    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final dencrypted = encrypter.decrypt64(encrypText, iv: iv);
    return dencrypted;
  }

  Map<String, dynamic> cipherMap(
    Map<String, dynamic> map,
    List<CipherMapOption> cipherOptions,
    bool? encryp,
  ) {
    try {
      for (var cipherOption in cipherOptions) {
        var valueProperty = _getPropertyFromMap(map, cipherOption.nameProperty);
        if (valueProperty != null) {
          if (cipherOption.isMap) {
            Map<String, dynamic>? mapOption =
                cipherMap(valueProperty, cipherOption.cipherOptions!, encryp);
            map[cipherOption.nameProperty] = mapOption;
          } else if (valueProperty is String &&
              (valueProperty.trim().isNotEmpty)) {
            map[cipherOption.nameProperty] =
                encryp! ? encryptAES(valueProperty) : decryptAES(valueProperty);
          } else {
            map[cipherOption.nameProperty] = null;
          }
        } else {
          map[cipherOption.nameProperty] = null;
        }
      }
      return map;
    } catch (ex) {
      log(ex.toString(), name: 'cipherMap');
      return map;
    }
  }

  dynamic _getPropertyFromMap(Map<String, dynamic> map, String key) {
    try {
      if (map.containsKey(key)) {
        return map[key];
      } else {
        return null;
      }
    } catch (ex) {
      log(ex.toString(), name: '_getPropertyFromMap');
      return null;
    }
  }
}

class CipherMapOption {
  String nameProperty;
  bool isMap;
  List<CipherMapOption>? cipherOptions;

  CipherMapOption(
    this.nameProperty, {
    this.isMap = false,
    this.cipherOptions,
  });
}
