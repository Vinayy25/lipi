import 'dart:io';

import 'package:flutter/material.dart';

class ChatModel {
  File? audio;
  TimeOfDay? time;
  String? text;
  bool isPlaying = false;
  bool? isPaused;
  ChatModel({this.audio, this.time, this.text, this.isPlaying = false, this.isPaused});
}
