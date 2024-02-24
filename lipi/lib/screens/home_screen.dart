import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final record = AudioRecorder();

  void isPressed() async {
    if (await record.hasPermission()) {
      await record.start(const RecordConfig(), path: 'aFullPath/myFile.m4a');
      final stream = await record
          .startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
      print('Permission Granted');
    } else {
      var status = await Permission.microphone.request();
      if (status.isGranted) {
        await record.start(const RecordConfig(), path: 'aFullPath/myFile.m4a');
        final stream = await record
            .startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
        print('Permission Granted');
      } else {
        print('Permission Denied');
      }
    }
  }

  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Lipi',
          style: TextStyle(fontFamily: ''),
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => setState(() {
            isRecording = !isRecording;
            isPressed();
          }),
          onLongPress: () {
            setState(() => isRecording = !isRecording);
            isPressed();
          },
          onLongPressEnd: (details) {
            setState(() => isRecording = !isRecording);
          },
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: isRecording
                ? Lottie.asset('assets/animations/voice_recording_inwhite.json',
                    frameRate: FrameRate.max,
                    repeat: true,
                    reverse: true,
                    fit: BoxFit.contain)
                : const Icon(
                    Icons.mic,
                    color: Colors.white,
                    size: 50,
                  ),
          ),
        ),
      ),
    );
  }
}
