import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:text_to_image_gen/Pages/splash_screen.dart';
import 'package:text_to_image_gen/utils/my_states.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SentryFlutter.init(
        (options) => options.dsn = 'https://725035c013bd4e7495b4fc7e472f6c5f@o4505074740953088.ingest.sentry.io/4505074742132736',
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (context) => ThemeState()),
    ],
    builder: (context, _) {
      final themeState = Provider.of<ThemeState>(context);
      themeState.getTheme();
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: themeState.currentThemeMode,
        theme: themeState.getLightTheme(),
        darkTheme: themeState.getDarkTheme(),
        home: const SplashScreen(),
      );
    });
  }
}