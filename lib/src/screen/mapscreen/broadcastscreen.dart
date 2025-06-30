import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';

class BroadcasterScreen extends StatefulWidget {
  @override
  _BroadcasterScreenState createState() => _BroadcasterScreenState();
}

class _BroadcasterScreenState extends State<BroadcasterScreen> {
  final _localRenderer = RTCVideoRenderer();
  RTCPeerConnection? _peerConnection;
  final roomRef = FirebaseFirestore.instance.collection("rooms").doc("room-123");

  bool isBroadcasting = false;
  bool permissionsGranted = false;

  @override
void initState() {
  super.initState();
  initRenderer();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    checkAndRequestPermissions();
  });
}


  Future<void> initRenderer() async {
    await _localRenderer.initialize();
  }

Future<void> checkAndRequestPermissions() async {
  final statuses = await [
    Permission.camera,
    Permission.microphone,
  ].request();

  final cameraGranted = statuses[Permission.camera] == PermissionStatus.granted;
  final micGranted = statuses[Permission.microphone] == PermissionStatus.granted;

  setState(() {
    permissionsGranted = cameraGranted && micGranted;
  });
}




  Future<void> startBroadcast() async {
    setState(() => isBroadcasting = true);

    final stream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': {
        'facingMode': 'user',
        'width': 1280,
        'height': 720,
        'frameRate': 30,
      }
    });

    _localRenderer.srcObject = stream;

    final config = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'}
      ]
    };

    _peerConnection = await createPeerConnection(config);
    stream.getTracks().forEach((track) {
      _peerConnection!.addTrack(track, stream);
    });

    final offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);
    await roomRef.set({'offer': offer.toMap()});

    roomRef.snapshots().listen((snapshot) async {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        if (data.containsKey('answer')) {
          final answer = RTCSessionDescription(
            data['answer']['sdp'],
            data['answer']['type'],
          );
          if (_peerConnection!.signalingState != RTCSignalingState.RTCSignalingStateStable) {
            await _peerConnection!.setRemoteDescription(answer);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _peerConnection?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Broadcaster")),
      body: permissionsGranted
    ? Column(
        children: [
          Expanded(child: RTCVideoView(_localRenderer, mirror: true)),
          if (!isBroadcasting)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: startBroadcast,
                child: Text("Start Broadcast"),
              ),
            ),
        ],
      )
    : Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Camera and microphone permissions are required to start the broadcast.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: checkAndRequestPermissions,
                child: Text("Grant Permissions"),
              ),
            ],
          ),
        ),
      ));
  }
}
