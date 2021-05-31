class ReqLogin {
  int customerSK;
  String needLangaugeLabel;
  String shopSK;
  String status;

  ReqLogin({this.customerSK, this.needLangaugeLabel, this.shopSK, this.status});

  ReqLogin.fromJson(dynamic json) {
    customerSK = json["CustomerSK"];
    needLangaugeLabel = json["NeedLangaugeLabel"];
    shopSK = json["ShopSK"];
    status = json["Status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["CustomerSK"] = customerSK;
    map["NeedLangaugeLabel"] = needLangaugeLabel;
    map["ShopSK"] = shopSK;
    map["Status"] = status;
    return map;
  }
}
