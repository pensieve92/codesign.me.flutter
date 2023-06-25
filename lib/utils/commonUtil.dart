import 'package:flutter/material.dart';

@Deprecated("flutter_keyboard_visibility 로 대체")
// bool 키보드 show 여부
bool gf_isShowKeyboard(BuildContext context){
  return MediaQuery.of(context).viewInsets.bottom != 0.0;
}

@Deprecated("flutter_keyboard_visibility 로 대체")
// bool 키보드 show 여부
bool isShowKeyboard(BuildContext context){
  return MediaQuery.of(context).viewInsets.bottom != 0.0;
}