import 'package:e_commerce/data/model/invoice_create_response_model.dart';
import 'package:get/get.dart';
import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
class CreateInvoiceController extends GetxController{
  bool _paymentInProgress = false;
  String _message ='';
  //model class
   InvoiceCreateResponseModel _invoiceCreateResponseModel = InvoiceCreateResponseModel();

  //getter method
  bool get paymentInProgress =>_paymentInProgress;
  String get message => _message;

  InvoiceCreateData? get invoiceCreateResponseModel =>_invoiceCreateResponseModel.data?.first;

  //method for check is user SignedIn or not
  Future<bool> createInvoice() async{
    _paymentInProgress=true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.createInvoice);
    _paymentInProgress=false;
    update();
    if(response.isSuccess && response.responseJson!['msg']=='success'){

      _invoiceCreateResponseModel=InvoiceCreateResponseModel.fromJson(response.responseJson!);
    return true;
    } else{
      _message = 'Invoice creation failed! Try again';
      return false;
    }


  }
}