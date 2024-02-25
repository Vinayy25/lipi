import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_sound/flutter_sound.dart';

class RecordingProvider extends ChangeNotifier {
  bool isRecording = false;

  final recorder = FlutterSoundRecorder();

  bool isFileAvailable = false;



  bool checkFile(){
    if(_filePath!=null){
      isFileAvailable = true;
    }
    return false;
  }

  final player = FlutterSoundPlayer();

  playSound()async{
    await player.openPlayer();
   await  player.startPlayer(fromURI: _filePath);

  


  

  }

  Stream<Uint8List>? stream;
  void setIsRecording(bool value) {
    isRecording = value;
    notifyListeners();
  }

  Duration duration = const Duration();

  String? _filePath;

  bool get getIsRecording => isRecording;

  void startRecording() async {
    setIsRecording(true);

    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));

    await recorder.startRecorder(
        toFile: _filePath,
        // codec: Codec.aacADTS,

        codec: Codec.aacMP4);
    print("\n\n\nthis is the file path$_filePath\n\n\n");
    notifyListeners();
  }

  void stopRecording() async {
    setIsRecording(false);
    String? respose = await recorder.stopRecorder();
    print(respose.toString());
    await recorder.closeRecorder();
    notifyListeners();
  }

  Future<bool> checkPermission() async {
    if (await Permission.microphone.isGranted == true) {
      final appDir = await getApplicationDocumentsDirectory();
      print("resonse is : " + appDir.path);
      _filePath = '${appDir.path}/current_recording.m4a';
      print('app directory is $appDir');

      print('Permission Granted');
      return true;
    } else {
      var status = await Permission.microphone.request();

      if (status.isGranted) {
        print('Permission Granted');
        return true;
      } else {
        print('Permission Denied');
        return false;
      }
    }
  }
}
