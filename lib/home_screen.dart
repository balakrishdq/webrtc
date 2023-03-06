import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _localVideoRenderer = RTCVideoRenderer();

    void initRenderes() async {
      await _localVideoRenderer.initialize();
    }

    getUserMedia() async {
      final Map<String, dynamic> mediaConstraints = {
        "audio": true,
        "video": {
          'facingMode': 'user',
        }
      };

      MediaStream stream =
          await navigator.mediaDevices.getUserMedia(mediaConstraints);
      _localVideoRenderer.srcObject = stream;
    }

    @override
    void initState() {
      super.initState();
      initRenderes();
      getUserMedia();
    }

    @override
    void dispose() async {
      await _localVideoRenderer.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0.0,
            right: 0.0,
            left: 0.0,
            bottom: 0.0,
            child: RTCVideoView(_localVideoRenderer),
          ),
        ],
      ),
    );
  }
}
