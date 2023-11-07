import 'package:flutter/material.dart';
import 'application/app.dart';
import 'package:get_storage/get_storage.dart';
void main() async{
  await GetStorage.init();
  runApp(const CraftyBay());
}


