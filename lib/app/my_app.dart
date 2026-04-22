import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/provider/dark_mode.dart';
import 'package:todo_list/provider/tasks_provider.dart';
import 'package:todo_list/screens/splash_screen.dart';
import 'package:todo_list/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TasksProvider()),
        ChangeNotifierProvider(
          create: (_) => DarkModeProvider()..initializeDarkMode(),
        ),
      ],
      child: Consumer<DarkModeProvider>(
        builder: (context, mode, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Todo List Demo',
            theme: AppTheme.getTheme(mode.isDark),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}