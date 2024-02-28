import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordingProvider extends ChangeNotifier {
  bool isRecording = false;

  PlayerController playerController = PlayerController();

  RecorderController recorderController = RecorderController()
    ..androidEncoder = AndroidEncoder.aac
    ..androidOutputFormat = AndroidOutputFormat.mpeg4
    ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
    ..sampleRate = 16000;
  bool isFileAvailable = false;
  String? myfilePath;

  bool checkFile() {
    if (myfilePath != null) {
      isFileAvailable = true;
    }
    notifyListeners();

    return false;
  }

  playSound() async {
    await playerController.startPlayer();
    notifyListeners();
  }

  void setIsRecording(bool value) {
    isRecording = value;
    notifyListeners();
  }

  bool get getIsRecording => isRecording;

  void startRecording() async {
    setIsRecording(true);
    //clean the path
    recorderController.refresh();
    recorderController.reset();

    notifyListeners();

    await recorderController.record(path: myfilePath);

    print("\n\n\nthis is the file path$myfilePath\n\n\n");
    notifyListeners();
  }

  void stopRecording() async {
    setIsRecording(false);

    myfilePath = await recorderController.stop();

    print("this is my file path here: $myfilePath");
    await playerController.preparePlayer(
      path: myfilePath!,
    );

    await audioPlayer.setSourceDeviceFile(myfilePath!);

    playSound();
    playerController.stopAllPlayers();

    notifyListeners();
  }

  Future<bool> checkPermission() async {
    if (await Permission.microphone.isGranted == true) {
      final appDir = await getApplicationDocumentsDirectory();
      print("resonse is : " + appDir.path);
      myfilePath = '${appDir.path}/current_recording.m4a';
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
