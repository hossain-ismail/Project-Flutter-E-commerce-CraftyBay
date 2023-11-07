class InvoiceListModel {
  int? id;
  String? total;
  String? vat;
  String? payable;
  String? cusDetails; // Change to String
  String? shipDetails; // Change to String
  String? tranId;
  String? valId;
  String? deliveryStatus; // Change to String
  String? paymentStatus; // Change to String
  int? userId;
  String? createdAt;
  String? updatedAt;

  InvoiceListModel({
    this.id,
    this.total,
    this.vat,
    this.payable,
    this.cusDetails,
    this.shipDetails,
    this.tranId,
    this.valId,
    this.deliveryStatus,
    this.paymentStatus,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  InvoiceListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    vat = json['vat'];
    payable = json['payable'];
    cusDetails = json['cus_details']; // Parse as String
    shipDetails = json['ship_details']; // Parse as String
    tranId = json['tran_id'];
    valId = json['val_id'];
    deliveryStatus = json['delivery_status']; // Parse as String
    paymentStatus = json['payment_status']; // Parse as String
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['total'] = total;
    data['vat'] = vat;
    data['payable'] = payable;
    data['cus_details'] = cusDetails;
    data['ship_details'] = shipDetails;
    data['tran_id'] = tranId;
    data['val_id'] = valId;
    data['delivery_status'] = deliveryStatus;
    data['payment_status'] = paymentStatus;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
