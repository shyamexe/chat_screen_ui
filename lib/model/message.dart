import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Message {
  final String? text;
  final String? imageUrl;
  final String? audioUrl;
  final DateTime date;
  final bool isSent;
  Message({
    this.text,
    this.imageUrl,
    this.audioUrl,
    required this.date,
    required this.isSent,
  });

}