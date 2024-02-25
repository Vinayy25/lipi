import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:lipi/states/recording_state.dart';
import 'package:lipi/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: Consumer<RecordingProvider>(builder: (context, provider, child) {
        return Column(
          children: [
            StreamBuilder<RecordingDisposition>(
              builder: (context, snapshot) {
                final duration =
                    snapshot.hasData ? snapshot.data!.duration : Duration.zero;

                String twoDigits(int n) => n.toString().padLeft(2, '0');

                final twoDigitMinutes =
                    twoDigits(duration.inMinutes.remainder(60));
                final twoDigitSeconds =
                    twoDigits(duration.inSeconds.remainder(60));

                return Text(
                  '$twoDigitMinutes:$twoDigitSeconds',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
              stream: provider.recorder.onProgress,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  if (await provider.checkPermission() == true) {
                    if (provider.getIsRecording) {
                      provider.stopRecording();
                    } else {
                      provider.startRecording();
                    }
                  }
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
                  child: provider.getIsRecording == true
                      ? Lottie.asset(
                          'assets/animations/voice_recording_inwhite.json',
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
            const SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.red,
              child: IconButton(
                onPressed: () {
                  if (provider.checkFile()) {
                    provider.playSound();
                  } else {
                    print("file not available");
                  }
                },
                icon: const Icon(Icons.play_arrow),
              ),
            )
          ],
        );
      }),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 50,
            shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            title: const AppLargeText(
              text: 'Lipi',
              color: Colors.white,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0),
        extendBody: true,
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            Consumer<RecordingProvider>(builder: (context, provider, child) {
          return GestureDetector(
            onTap: () async {
              if (await provider.checkPermission() == true) {
                if (provider.getIsRecording) {
                  provider.stopRecording();
                } else {
                  provider.startRecording();
                }
              }
            },
            child: Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  )
                ],
                shape: BoxShape.circle,
                color: Color.fromRGBO(53, 55, 75, 1),
              ),
              child: provider.getIsRecording == true
                  ? Lottie.asset(
                      'assets/animations/voice_recording_inwhite.json',
                      frameRate: FrameRate.max,
                      repeat: true,
                      reverse: true,
                      fit: BoxFit.contain)
                  : const Icon(size: 35, Icons.mic, color: Colors.white),
            ),
          );
        }),
        body: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  transform: GradientRotation(0.7),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromRGBO(53, 65, 75, 1),
                Colors.deepPurple,
                Colors.black
              ])),
          child: ListView.builder(
            itemCount: 50,
            itemBuilder: (context, index) {
              return Container(
                alignment:
                    (index % 2 == 0) ? Alignment.topLeft : Alignment.topRight,
                child: AppText(
                  text: 'Item $index',
                  color: Colors.white,
                ),
              );
            },
          ),
        ));
  }
}
