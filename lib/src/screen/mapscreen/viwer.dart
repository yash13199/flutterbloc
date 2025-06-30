import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewerScreen extends StatefulWidget {
  @override
  _ViewerScreenState createState() => _ViewerScreenState();
}

class _ViewerScreenState extends State<ViewerScreen> {
  final _remoteRenderer = RTCVideoRenderer();
  RTCPeerConnection? _peerConnection;
  final roomRef = FirebaseFirestore.instance.collection("rooms").doc("room-123");

  @override
  void initState() {
    super.initState();
    initRenderer();
    startViewer();
  }

  Future<void> initRenderer() async {
    await _remoteRenderer.initialize();
  }

  Future<void> startViewer() async {
    final config = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'}
      ]
    };

    _peerConnection = await createPeerConnection(config);

    _peerConnection!.onTrack = (event) {
      if (event.track.kind == 'video') {
        _remoteRenderer.srcObject = event.streams.first;
      }
    };

    final roomSnapshot = await roomRef.get();
    if (roomSnapshot.exists) {
      final data = roomSnapshot.data()!;
      final offer = data['offer'];
      await _peerConnection!.setRemoteDescription(
        RTCSessionDescription(offer['sdp'], offer['type']),
      );

      final answer = await _peerConnection!.createAnswer();
      await _peerConnection!.setLocalDescription(answer);
      await roomRef.update({'answer': answer.toMap()});
    } else {
      print("Room not found");
    }
  }

  @override
  void dispose() {
    _remoteRenderer.dispose();
    _peerConnection?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Viewer")),
      body: Center(child: RTCVideoView(_remoteRenderer)),
    );
  }
}
