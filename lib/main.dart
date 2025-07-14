import 'package:event_ticket_booking1/color.dart';
import 'package:flutter/material.dart';
import 'screens/landing_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'local/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.light);
  final ValueNotifier<Locale> _locale = ValueNotifier(const Locale('en'));

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeMode,
      builder: (context, mode, _) {
        return ValueListenableBuilder<Locale>(
          valueListenable: _locale,
          builder: (context, locale, _) {
            return MaterialApp(
              supportedLocales: const [
                Locale('en'),
                Locale('de'),
              ],
              locale: locale,
              localizationsDelegates: [
                const AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              title: 'Event Ticket Booking',
              theme: ThemeData(primarySwatch: Colors.deepPurple),
              themeMode: mode,
              home: LandingScreen(
                  themeModeNotifier: _themeMode, localeNotifier: _locale),
            );
          },
        );
      },
    );
  }
}
