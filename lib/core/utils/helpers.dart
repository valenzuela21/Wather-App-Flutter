import 'dart:io';

import 'package:flutter/material.dart';

class Helpers {
  static void systemPrint(String txt){
    if(Platform.isIOS){
      debugPrint(txt);
    }else{
      print(txt);
    }
  }
}