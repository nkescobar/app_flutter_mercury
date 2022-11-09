import 'dart:convert';

class CaptchaMessage {
  bool token;
  bool visibility;
  String message;

  CaptchaMessage({
    required this.token,
    required this.visibility,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'visibility': visibility,
      'message': message,
    };
  }

  factory CaptchaMessage.fromMap(Map<String, dynamic> map) {
    return CaptchaMessage(
      token: map['token'],
      visibility: map['visibility'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CaptchaMessage.fromJson(String source) =>
      CaptchaMessage.fromMap(json.decode(source));
}
