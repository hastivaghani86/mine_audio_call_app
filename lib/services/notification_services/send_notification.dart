import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mine/utils/all_keys.dart';

void sendFcmMessage(String fcmToken, String title, String body) async {
  Uri url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  String serverKey = serverSecret ; // Be very cautious with your server key, it should not be hardcoded in production apps
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };
  Map<String, dynamic> notification = {
    'body': body,
    'title': title,
  };
  Map<String, dynamic> payload = {
    'notification': notification,
    'priority': 'high',
    'data': {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done'
    },
    'to': fcmToken,
  };

  http.Response response = await http.post(
    url,
    headers: headers,
    body: json.encode(payload),
  );

  if (response.statusCode == 200) {
    print("Notification sent");
  } else {
    print("Failed to send notification: ${response.body}");
  }
}
