import 'dart:math';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


// String agoraAppId ="b9afe1385e4a452dba0a1cdf52cc7bdc";
// String tempToken = "007eJxTYDDcccThnZEbM7s+f7vo+zqGlHD18iU/vwg7vb6RZ+r89oUCQ5JlYlqqobGFaapJoompUUpSokGiYXJKmqlRcrJ5Ukry1mzJtIZARoaliR7MjAwQCOKzMiTmZhZnMDAAAA2RHyE=";

const String appId = "06e8476e8f074f539f05112e02d048b1";

class AgoraVideoCallExa extends StatefulWidget {
  int? remoteUid;
   AgoraVideoCallExa({required int remoteUid,Key? key}) : super(key: key);

  @override
  _AgoraVideoCallExaState createState() => _AgoraVideoCallExaState();
}

class _AgoraVideoCallExaState extends State<AgoraVideoCallExa> {
  String channelName = "amish";
  String? token; // Define token as nullable

  int uid = 0; // uid of the local user

  // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  late RtcEngine agoraEngine; // Agora engine instance

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void initState() {
    super.initState();
    // Set up an instance of Agora engine
    setupVoiceSDKEngine();
    // Generate token asynchronously
    generateToken();
  }

  Future<void> generateToken() async {
    // Generate token asynchronously
    token = await generateAgoraToken();
    setState(() {}); // Trigger rebuild after token generation
  }

  Future<String> generateAgoraToken() async {
    // Generate token using your preferred method, for example, from a backend server
    // For demonstration purposes, we'll just return a dummy token
    return  "007eJxTYDDcccThnZEbM7s+f7vo+zqGlHD18iU/vwg7vb6RZ+r89oUCQ5JlYlqqobGFaapJoompUUpSokGiYXJKmqlRcrJ5Ukry1mzJtIZARoaliR7MjAwQCOKzMiTmZhZnMDAAAA2RHyE=";
  }

  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    // create an instance of the Agora engine
    agoraEngine = await createAgoraRtcEngine();

    await agoraEngine.initialize(const RtcEngineContext(
      appId: appId,
    ));

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage(
              "Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          setState(() {
            widget.remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          setState(() {
            widget.remoteUid = null;
          });
        },
      ),
    );
  }

  void join() async {
    // Check if token is available
    if (token == null) {
      showMessage("Token not available yet. Please wait.");
      return;
    }

    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: token!,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }

  void leave() {
    setState(() {
      _isJoined = false;
      widget.remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Get started with Voice Calling'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          children: [
            // Status text
            Container(
              height: 40,
              child: Center(child: _status()),
            ),
            // Button Row
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    child: const Text("Join"),
                    onPressed: () => join(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    child: const Text("Leave"),
                    onPressed: () => leave(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _status() {
    String statusText;

    if (!_isJoined)
      statusText = 'Join a channel';
    else if (widget.remoteUid == null)
      statusText = 'Waiting for a remote user to join...';
    else
      statusText = 'Connected to remote user, uid:${widget.remoteUid}';

    return Text(
      statusText,
    );
  }
}