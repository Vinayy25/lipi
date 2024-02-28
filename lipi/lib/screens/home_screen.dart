import 'dart:ui' as ui;
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
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
            // StreamBuilder<RecordingDisposition>(
            //   builder: (context, snapshot) {
            //     final duration =
            //         snapshot.hasData ? snapshot.data!.duration : Duration.zero;

            //     String twoDigits(int n) => n.toString().padLeft(2, '0');

            //     final twoDigitMinutes =
            //         twoDigits(duration.inMinutes.remainder(60));
            //     final twoDigitSeconds =
            //         twoDigits(duration.inSeconds.remainder(60));

            //     return Text(
            //       '$twoDigitMinutes:$twoDigitSeconds',
            //       style: const TextStyle(
            //         color: Colors.black,
            //         fontSize: 50,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     );
            //   },
            //   stream: (provider.recorderController.isRecording)?,
            // ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  if (await provider.checkPermission() == true) {
                    if (provider.isRecording) {
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
                  child: provider.isRecording == true
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

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? path;

  // Initialise
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 50,
          shape: const RoundedRectangleBorder(
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
              if (provider.isRecording) {
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
            child: provider.isRecording == true
                ? Lottie.asset('assets/animations/voice_recording_inwhite.json',
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
        child: Consumer<RecordingProvider>(builder: (context, provider, child) {
          return Center(
              child: provider.recorderController.isRecording == true
                  ? AudioWaveforms(
                      size: Size(MediaQuery.of(context).size.width, 200.0),
                      recorderController: provider.recorderController,
                      enableGesture: true,
                      waveStyle: WaveStyle(
                        showDurationLabel: true,
                        spacing: 8.0,
                        showBottom: false,
                        extendWaveform: true,
                        scaleFactor: 100,
                        showMiddleLine: false,
                        gradient: ui.Gradient.linear(
                          const Offset(70, 50),
                          Offset(MediaQuery.of(context).size.width / 2, 0),
                          [Colors.red, Colors.green],
                        ),
                      ),
                    )
                  : AudioFileWaveforms(
                      size: Size(MediaQuery.of(context).size.width, 100.0),
                      playerController: provider.playerController,
                      enableSeekGesture: true,
                      waveformType: WaveformType.long,
                      waveformData: [],
                      playerWaveStyle: const PlayerWaveStyle(
                        fixedWaveColor: Colors.white54,
                        liveWaveColor: Colors.blueAccent,
                        spacing: 6,
                      ),
                    ));
        }),
      ),
    );
  }
}
