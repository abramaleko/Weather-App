import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weatherProvider.dart';
import 'package:weather_app/screens/home_page.dart';

import 'Model/pushNotification.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

// Lisitnening to the background messages
  // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   await Firebase.initializeApp();
  //   print("Handling a background message: ${message.messageId}");
  // }

  // Listneing to the foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Parse the message received
    PushNotification notification = PushNotification(
      title: message.notification?.title,
      body: message.notification?.body,
    );
    
    if (notification.title !=null) {
        showSimpleNotification(
          Text(notification.title!),
          // leading: NotificationBadge(totalNotifications: _totalNotifications),
          subtitle: Text(notification.body!),
          background: const Color.fromARGB(255, 84, 194, 206),
          duration: const Duration(seconds: 3),
        );
    } 
  });

  runApp(
    ChangeNotifierProvider(
      create: ((context) => WeatherProvider()),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        home: HomePage(),
      ),
    );
  }
}
