import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final _plugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _plugin.initialize(
    settings: const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
    onDidReceiveNotificationResponse: (response) {
      debugPrint('onDidReceiveNotificationResponse: $response');
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('cancelNotification test')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: _showNotification,
                child: const Text('Show notification (tag + showsUserInterface)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showNotification() async {
  await _plugin.show(
    id: 0,
    title: 'Test',
    body: 'Tap Dismiss — should cancel this notification',
    notificationDetails: const NotificationDetails(
      android: AndroidNotificationDetails(
        'test_channel',
        'Test Channel',
        tag: 'my_tag',
        actions: [
          AndroidNotificationAction(
            'dismiss',
            'Dismiss',
            showsUserInterface: true,
            cancelNotification: true,
          ),
        ],
      ),
    ),
  );
}
