import 'dart:developer';

import 'package:get/get.dart';
import '../../data/model/invoice_list_model_purchased_history.dart';
import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
class InvoiceListController extends GetxController{

  List<InvoiceListModel>_invoiceList = [];
  bool _invoiceListInProgress = false;
  String _message ='';
  //getter method
  bool get invoiceListInProgress =>_invoiceListInProgress;
  String get message => _message;
  List<InvoiceListModel> get getInvoiceList =>_invoiceList;

  Future<bool> fetchInvoiceList() async{
    _invoiceListInProgress=true;
    update();
    //apply new getRequest for invoice only
   final NetworkResponse response = await NetworkCaller.getRequestInVoice(Urls.invoiceList);

    if(response.isSuccess){
      print("Inside success condition");
      var data = response.responseJson as List<dynamic>;
      _invoiceList.clear();
      for(Map<String,dynamic>userInvoice in data){
        _invoiceList.add(InvoiceListModel.fromJson(userInvoice));
      }
      _invoiceListInProgress=false;
      update();
      return true;
    } else{
      _message = "Can't get Purchase history, tray again !";

      _invoiceListInProgress=false;
      update();
      return false;
    }


  }
}