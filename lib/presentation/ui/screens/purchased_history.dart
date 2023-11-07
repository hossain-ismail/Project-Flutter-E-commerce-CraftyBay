import 'package:e_commerce/presentation/state_holders/invoice_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/read_profile_model.dart';
import '../../state_holders/read_profile_controller.dart';

class PurchasedHistory extends StatefulWidget {
  const PurchasedHistory({super.key});

  @override
  State<PurchasedHistory> createState() => _PurchasedHistoryState();
}

class _PurchasedHistoryState extends State<PurchasedHistory> {
  ReadProfileModel profileInformation =
      Get.find<ReadProfileController>().readProfileModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<InvoiceListController>().fetchInvoiceList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = 4;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchased Product '),
      ),
      body: GetBuilder<InvoiceListController>(builder: (invoiceListController) {
        if (invoiceListController.invoiceListInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (invoiceListController.getInvoiceList.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                "You haven't purchase any product yet!",
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        }
        return ListView.builder(
            itemCount: invoiceListController.getInvoiceList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Customer name : ${profileInformation.data?.cusName ?? ''}'),
                        SizedBox(
                          height: height,
                        ),
                        Text(
                            "Total Payment : ${invoiceListController.getInvoiceList[index].total}"),
                        SizedBox(
                          height: height,
                        ),
                        Text(
                            "Payment Status : ${invoiceListController.getInvoiceList[index].paymentStatus}"),
                        SizedBox(
                          height: height,
                        ),
                        Text(
                            "Delivery Status : ${invoiceListController.getInvoiceList[index].deliveryStatus}"),
                        SizedBox(
                          height: height,
                        ),
                        Text(
                            "Order time : ${invoiceListController.getInvoiceList[index].createdAt}")
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }
}
