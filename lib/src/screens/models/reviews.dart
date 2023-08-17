import 'dart:ffi';

import 'package:flutter/material.dart';
class ReviewData {//unvisitedで使うコンストラクタ
  final String shopname;
  final String dishname;
  final Int evaluate;
  final String content;
  final DateTime created_at;

  ReviewData({
    required this.shopname,
    required this.dishname,
    required this.evaluate,
    required this.content,
    required this.created_at,
  });
}