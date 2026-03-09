import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Request permission
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Initialize local notifications
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(initSettings);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(
        title: message.notification?.title ?? 'SaveOnix AI',
        body: message.notification?.body ?? '',
      );
    });

    // Get and print FCM token (you'll need this to send test notifications)
    String? token = await _messaging.getToken();
    print('FCM Token: $token');
  }

  static Future<void> _showLocalNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'saveonix_ai_channel',
      'SaveOnix AI Alerts',
      channelDescription: 'AI generated financial alerts',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      0,
      title,
      body,
      details,
    );
  }

  // Call this from the dashboard to trigger AI insight notifications
  static Future<void> sendAIInsightNotification({
    required String insight,
    required bool isOverspending,
  }) async {
    String title = isOverspending
        ? '⚠️ Spending Alert'
        : '💡 SaveOnix AI Insight';

    await _showLocalNotification(title: title, body: insight);
  }
}