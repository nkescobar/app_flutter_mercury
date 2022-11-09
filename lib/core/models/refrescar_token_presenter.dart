class RefrescarTokenPresenter {
  String? tokenActual;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tokenActual'] = tokenActual;
    return data;
  }
}
