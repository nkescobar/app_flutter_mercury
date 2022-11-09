class RefrescarTokenDomain {
  RefrescarTokenDomain({
    this.token,
    this.refrescado,
  });

  String? token;
  bool? refrescado;

  factory RefrescarTokenDomain.fromJson(Map<String, dynamic> json) =>
      RefrescarTokenDomain(
        token: json["token"],
        refrescado: json["refrescado"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "refrescado": refrescado,
      };
}
