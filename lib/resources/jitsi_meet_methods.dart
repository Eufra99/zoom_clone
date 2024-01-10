import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  void createMeeting(
      {required String roomName,
      required bool isAudioMuted,
      required bool isVideoMuted,
      String username = ''}) async {
    try {
      // Create a JitsiMeet object
      var jitsiMeet = JitsiMeet();

      String name;

      if (username.isEmpty) {
        name = _authMethods.user.displayName!;
      } else {
        name = username;
      }
      // Create a JitsiMeetConferenceOptions object
      var options = JitsiMeetConferenceOptions(
        room: roomName, // The room name
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
        },
        userInfo: JitsiMeetUserInfo(
            displayName: name,
            email: _authMethods.user.email,
            avatar: _authMethods.user.photoURL),
        featureFlags: {
          // The feature flags to enable or disable
          'welcomePageEnabled': false, // Disable the welcome page
          'resolution': 2
        },
      );

      _firestoreMethods.addToMeetingHistory(roomName);
      // Join the meeting with the options
      await jitsiMeet.join(options);
    } catch (error) {
      print("error: $error");
    }
  }
}
