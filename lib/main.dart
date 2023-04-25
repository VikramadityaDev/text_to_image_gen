import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:text_to_image_gen/Pages/splash_screen.dart';


Future<void> main() async {
  await SentryFlutter.init(
        (options) => options.dsn = 'https://725035c013bd4e7495b4fc7e472f6c5f@o4505074740953088.ingest.sentry.io/4505074742132736',
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.deepPurple.shade400,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}