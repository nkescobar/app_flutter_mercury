// ignore_for_file: unrelated_type_equality_checks

import 'dart:math';

class UUID {
  static String generarUUID() {
    const pattern = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx';
    return pattern.replaceAllMapped(RegExp(r'[xy]'), (match) {
      final random = Random().nextInt(16) | 0,
          // ignore: unused_local_variable
          v = match == 'x' ? random : (random & 0x3 | 0x8);
      return random.toRadixString(16);
    });
  }
}
