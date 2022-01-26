import 'package:flutter/cupertino.dart';

class Translate {
  static final Translate _translate = Translate._internal();

  Translate._internal();

  factory Translate() {
    return _translate;
  }

  BuildContext? context;

  setContext(BuildContext context) {
    this.context = context;
  }



}
