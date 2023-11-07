import 'dart:developer';
import 'package:e_commerce/data/model/payment_method.dart';
import 'package:e_commerce/presentation/state_holders/create_invoice_controller.dart';
import 'package:e_commerce/presentation/ui/screens/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isCompleted = false;
  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      Get.find<CreateInvoiceController>().createInvoice().then((value){
        isCompleted=value;
        if(mounted){
          setState(() {
            
          });
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Check out'),),
      body: GetBuilder<CreateInvoiceController>(
        builder: (createInvoiceController) {
          if(createInvoiceController.paymentInProgress){
            return const Center(child: CircularProgressIndicator());
          }

          if(!isCompleted){
            return const Text('Please complete your profile first');
          }
          return ListView.separated(
              itemCount: createInvoiceController.invoiceCreateResponseModel?.paymentMethod?.length?? 0,
            itemBuilder: (context,index){
                final PaymentMethod paymentMethod = createInvoiceController.invoiceCreateResponseModel!.paymentMethod![index];
            return ListTile(
              leading: Image.network(paymentMethod.logo?? '', width: 60,),
              title: Text(paymentMethod.name?? ''),
              onTap: (){
                log("index number is $index");
                log("The url of payment is : ${paymentMethod.redirectGatewayURL!}");

                Get.off(()=>WebViewScreen(paymentUrl:paymentMethod.redirectGatewayURL!));
              },


            );
          }, separatorBuilder: (_,__){
                return Divider();
          },);
        }
      ),
    );
  }
}
