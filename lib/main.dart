import 'package:flutter/material.dart';
import 'controllers/app_state.dart';
import 'screens/main_navigation_shell.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const NaghdENoApp());
}

class NaghdENoApp extends StatefulWidget {
  const NaghdENoApp({super.key});

  @override
  State<NaghdENoApp> createState() => _NaghdENoAppState();
}

class _NaghdENoAppState extends State<NaghdENoApp> {
  final AppState _appState = AppState();

  @override
  Widget build(BuildContext context) {
    return AppStateProvider(
      appState: _appState,
      child: MaterialApp(
        title: 'نقد نو | Naghd-e No',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },
        home: const MainNavigationShell(),
      ),
    );
  }
}
