import 'package:flutter/material.dart';
import 'package:flutter_platform_code/pages/battery_level_page.dart';
import 'package:flutter_platform_code/pages/color_change.dart';
import 'package:flutter_platform_code/pages/ringtone_page.dart';
import 'package:flutter_platform_code/pages/toast_bar_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/RingtonePage': (_) => const RingtonePage(),
        '/ToastBarPage': (_) => const ToastBarPage(),
        '/ChangeColorPage': (_) => const ChangeColorPage(),
        '/BatteryLevelPage': (_) => const BatteryLevelPage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/RingtonePage");
              },
              child: const Text('Список рингтонов'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/ToastBarPage");
              },
              child: const Text('Экран вызова Тоаст Бара'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/ChangeColorPage");
              },
              child: const Text('Экран нативного изменения цвета'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/BatteryLevelPage");
              },
              child: const Text('Уровень батареи в процентах'),
            ),
          ],
        ),
      ),
    );
  }
}
