// choose_role_screen.dart
import 'package:flutter/material.dart';
import 'package:flutterbloc/src/screen/mapscreen/broadcastscreen.dart';
import 'package:flutterbloc/src/screen/mapscreen/viwer.dart';

class ChooseRoleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("60 FPS WebRTC Streaming")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Start Broadcaster"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BroadcasterScreen()),
              ),
            ),
            ElevatedButton(
              child: Text("Start Viewer"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ViewerScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
