
import 'dart:async';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String> getSmsMessageBody() async {
  SmsQuery query = SmsQuery();

  final PermissionStatus permission = await Permission.sms.status;
  if (!permission.isGranted) {
    await Permission.sms.request();
    return ''; // Return empty string if permission is not granted.
  }

  // Keep querying for new messages and returning their message body.
  while (true) {
    List<SmsMessage> messages = await query.querySms(
      kinds: [SmsQueryKind.inbox, SmsQueryKind.sent],
      address: 'Star Points',
      count: 1,
    );
    if (messages.isNotEmpty) {
      String messageBody = '${messages[0].body}';
      // print(messageBody+"res");
      return messageBody;
    }
    await Future.delayed(Duration(seconds: 1)); // Wait for 1 second before checking again.
  }
}









