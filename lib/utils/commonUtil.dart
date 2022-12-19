import 'package:flutter/material.dart';

// bool 키보드 show 여부
bool gf_isShowKeyboard(BuildContext context){
  return MediaQuery.of(context).viewInsets.bottom != 0.0;
}