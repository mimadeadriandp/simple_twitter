import 'package:flutter/material.dart';

class PopEvent {
  final VoidCallback function;
  PopEvent({this.function}){
    this.function();
  }
}
