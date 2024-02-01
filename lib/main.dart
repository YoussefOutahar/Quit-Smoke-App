import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:quitsmoke/Services/Ads/ads_service.dart';
import 'package:quitsmoke/notification_manager.dart';
import 'package:quitsmoke/screens/splash_screen.dart';
import 'package:quitsmoke/theme.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'Services/Ads/AppOpen/app_lifecycle_reactor.dart';
import 'Services/Ads/AppOpen/app_open_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AdsService().init();
  await prepare();

  runApp(MyApp());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

Future<void> prepare() async {
  await _configureLocalTimeZone();

  Intl.defaultLocale = Platform.localeName;
  initializeDateFormatting(Platform.localeName, null);
  NotificationManager.initializeLocalNotifiations();
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late AppLifecycleReactor appLifecycleReactor;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appLifecycleReactor.listenToAppStateChanges();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    appLifecycleReactor = AppLifecycleReactor(
      appOpenAdManager: AppOpenAdManager()..loadAd(),
    );
    appLifecycleReactor.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        title: 'Quit Smoking',
        theme: themeData(context),
        home: SplashScreen(),
        darkTheme: darkThemeData(context),
        themeMode: ThemeMode.light,
      ),
    );
  }
}
